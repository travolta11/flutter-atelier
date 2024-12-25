import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:produitsapp/ProduitItem.dart';
import 'package:produitsapp/form/addProduitForm.dart';
import 'package:produitsapp/form/updateProduitForm.dart';
import 'package:produitsapp/list_produits_fav.dart';
import 'package:produitsapp/model/produit.dart';
import 'package:produitsapp/profile.dart';

class ListeProduits extends StatefulWidget {
  const ListeProduits({super.key});

  @override
  State<ListeProduits> createState() => _ListeProduitsState();
}

class _ListeProduitsState extends State<ListeProduits> {
  int _currentIndex = 0;
  String? userRole;
  final List<Widget> _pages = [
    Center(
      child: Text(
        'acceuil',
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    ListProduitsFav(),
    Profile(),
  ];
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String?> getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('utilisateur')
          .doc(user.uid)
          .get();
      return doc['role'] as String?;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getUserRole().then((role) {
      setState(() {
        userRole = role;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Color(0xFF1A1A1A),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2D2D2D),
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Color(0xFF2D2D2D),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Liste des produits",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A1A1A),
                Color(0xFF2D2D2D),
              ],
            ),
          ),
          child: _currentIndex == 0
              ? StreamBuilder(
                  stream: db.collection('produits').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Une erreur est survenue",
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      );
                    }
                    List<Produit> produits = snapshot.data!.docs.map((doc) {
                      return Produit.fromFirestore(doc);
                    }).toList();
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: produits.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  db
                                      .collection('produits')
                                      .doc(produits[index].id)
                                      .update({"fav": !produits[index].fav});
                                },
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.white,
                                icon: !produits[index].fav
                                    ? Icons.star_border
                                    : Icons.star,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15),
                                ),
                              ),
                              SlidableAction(
                                onPressed: userRole == 'admin'
                                    ? (BuildContext context) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: ProduitFormUpdate(
                                                initialData: {
                                                  'marque':
                                                      produits[index].marque,
                                                  'designation':
                                                      produits[index]
                                                          .designation,
                                                  'categorie':
                                                      produits[index].categorie,
                                                  'prix': produits[index].prix,
                                                  'quantite':
                                                      produits[index].quantite,
                                                  'image':
                                                      produits[index].image,
                                                  'fav': produits[index].fav,
                                                },
                                                onSubmit: (updatedProduit) {
                                                  db
                                                      .collection('produits')
                                                      .doc(produits[index].id)
                                                      .update(updatedProduit)
                                                      .then((_) {
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Produit mis à jour avec succès',
                                                        ),
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                    );
                                                  }).catchError((error) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Erreur : $error'),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    : null,
                                backgroundColor: userRole == 'admin'
                                    ? Colors.purple
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                              ),
                              SlidableAction(
                                onPressed: userRole == 'admin'
                                    ? (BuildContext context) {
                                        db
                                            .collection('produits')
                                            .doc(produits[index].id)
                                            .delete();
                                      }
                                    : null,
                                backgroundColor: userRole == 'admin'
                                    ? Colors.red
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15),
                                ),
                              ),
                            ],
                          ),
                          child: Card(
                            child: ProduitItem(produit: produits[index]),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : _pages[_currentIndex],
        ),
        floatingActionButton: _currentIndex == 0 && userRole == 'admin'
            ? FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ProduitForm(
                          onSubmit: (produitData) {
                            db.collection('produits').add(produitData).then((_) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Produit ajouté avec succès'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }).catchError((error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erreur : $error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          },
                        ),
                      );
                    },
                  );
                },
                label: Text('Ajouter'),
                icon: Icon(Icons.add),
                backgroundColor: Colors.purple,
              )
            : null,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favoris',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
              backgroundColor: Color(0xFF2D2D2D),
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}