/*import 'package:flutter/material.dart';
import 'package:produitsapp/form/addProduitForm.dart';
import 'package:produitsapp/model/produit.dart';
import 'package:produitsapp/produit_box.dart';

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  State<ProduitsList> createState() => _ProduitsListState();
}

//list des produit
List liste = [];

class _ProduitsListState extends State<ProduitsList> {
  final TextEditingController nomController = TextEditingController();

  void saveProduit(Produit produit) {
    setState(() {
      liste.add([produit, false]);
    });
  }

  onChanged(bool? value, int index) {
    setState(() {
      liste[index][1] = value;
    });
  }

  void delProduit(int index) {
    setState(() {
      liste.removeAt(index);
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Produits")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduitForm(onSubmit: saveProduit),
            ),
          ),
          child: Icon(Icons.add_box),
        ),
        body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: (context, index) {
            return ProduitBox(
              produit: liste[index][0],
              selProduit: liste[index][1],
              onChanged: (value) => onChanged(value, index),
              delProduit: (context) => delProduit(index),
            );
          },
        ),
      );
    }
  }
*/
