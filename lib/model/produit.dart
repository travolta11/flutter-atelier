import 'package:cloud_firestore/cloud_firestore.dart';

class Produit {
  String id;
  bool fav;
  String marque;
  String designation;
  String categorie;
  double prix;
  int quantite;
  String image;

  Produit({
    required this.id,
    required this.fav,
    required this.marque,
    required this.designation,
    required this.categorie,
    required this.prix,
    required this.quantite,
    required this.image,
  });

  factory Produit.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Produit(
      id: doc.id,
      fav: data['fav'] ?? false,
      marque: data['marque'] ?? '',
      designation: data['designation'] ?? '',
      categorie: data['categorie'] ?? '',
      prix: (data['prix'] ?? 0.0).toDouble(),
      quantite: data['quantite'] ?? 0,
      image: data['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fav': fav,
      'marque': marque,
      'designation': designation,
      'categorie': categorie,
      'prix': prix,
      'quantite': quantite,
      'image': image,
    };
  }
}
