import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:produitsapp/ProduitItem.dart';
import 'package:produitsapp/model/produit.dart';

class ListProduitsFav extends StatefulWidget {
  const ListProduitsFav({super.key});

  @override
  State<ListProduitsFav> createState() => _ListProduitsFavState();
}

class _ListProduitsFavState extends State<ListProduitsFav> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          db.collection('produits').where("fav", isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("une erreur est survenue"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'Aucun produit favori trouvé.',
            ),
          );
        }
        List<Produit> produits = snapshot.data!.docs.map((doc) {
          return Produit.fromFirestore(doc);
        }).toList();
        return ListView.builder(
            itemCount: produits.length,
            itemBuilder: (context, index) {
              return ProduitItem(produit: produits[index]);
            });
      },
    );
  }
}
