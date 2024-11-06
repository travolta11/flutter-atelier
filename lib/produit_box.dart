import 'package:flutter/material.dart';
import 'produit.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final VoidCallback onTap;

  const ProduitBox({
    super.key,
    required this.produit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 120,
          child: Row(
            children: [
              Image.network(produit.photo, width: 80, height: 80, fit: BoxFit.cover),
              const SizedBox(width: 10),
              Text(produit.libelle, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
