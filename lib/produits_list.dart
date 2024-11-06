import 'package:flutter/material.dart';
import 'add_produit.dart';
import 'produit.dart';
import 'dart:convert'; 

class ProduitsList extends StatefulWidget {
  const ProduitsList({super.key});

  @override
  ProduitsListState createState() => ProduitsListState();
}



class ProduitsListState extends State<ProduitsList> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController prixController = TextEditingController();

  List<Produit> liste = [];

  void showProduitDetails(Produit produit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(produit.libelle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            produit.photo.isNotEmpty
                ? Image.memory(base64Decode(produit.photo))
                : const Icon(Icons.image_not_supported, size: 100),
            const SizedBox(height: 10),
            Text("Description: ${produit.description}"),
            Text("Prix: ${produit.prix}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Fermer"),
          ),
        ],
      );
    },
  );
}


  void addProduit(String imageBase64) {
    setState(() {
      liste.add(Produit(
        libelle: nomController.text,
        description: descriptionController.text,
        prix: double.tryParse(prixController.text) ?? 0.0,
        photo: imageBase64,
      ));
      nomController.clear();
      descriptionController.clear();
      prixController.clear();
    });
  }

  void showAddProduitDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddProduit(
          nomController: nomController,
          descriptionController: descriptionController,
          prixController: prixController,
          onAdd: addProduit,
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produits"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddProduitDialog,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: liste.length,
        itemBuilder: (context, index) {
          final produit = liste[index];
          final decodedImage = base64Decode(produit.photo);
          return ListTile(
            leading: Image.memory(decodedImage, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(produit.libelle),
            onTap: () => showProduitDetails(produit),
          );
        },
      ),
    );
  }
}
