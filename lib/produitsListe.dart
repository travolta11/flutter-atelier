import 'package:flutter/material.dart';
import 'package:produits_app/add_produit.dart';
import 'package:produits_app/produit_box.dart';

class Produitsliste extends StatefulWidget {

  @override
  State<Produitsliste> createState() => _ProduitslisteState();

    const Produitsliste({super.key});

}

class _ProduitslisteState extends State<Produitsliste> {
 final List liste = [
    ["1 produit",false],
    ["2 produit",true],
    ["3 produit",false],
    ["4 produit",false],
    ["5 produit",false],
  ];

   final TextEditingController nomController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(title:const Text("Liste des produits"),),
    floatingActionButton: FloatingActionButton(onPressed: addProduit,child: const Icon(Icons.add),),
    body: ListView.builder(
      itemCount: liste.length,
      itemBuilder: (context, index){
        return ProduitBox(
        nomProduit:  liste[index][0],
        selProduit: liste[index][1],
        onChanged: (value) => onChanged(value, index),
        delProduit: (context) => delProduit(index),
        );
      }),
    );
    
    

  }

  void onChanged(bool? value, int index) {
    setState(() {
      liste[index][1]= value;
    });
  }

  void saveProduit(){
    setState(() {
      liste.add([nomController.text,false]);
      nomController.clear();
      Navigator.of(context).pop();

    });
  }

  void addProduit(){
    showDialog(
      context: context, 
      builder: (context){
      return AddProduit(
      nomController: nomController,
       onAdd: saveProduit,
        onCancel:(){
          Navigator.pop(context);
          },
          );
    });
  
  }

  void delProduit(int index){
    setState(() {
      liste.removeAt(index);
    });
  }
}