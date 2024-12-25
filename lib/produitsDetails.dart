/*import 'dart:io';
import 'package:flutter/material.dart';
import 'package:produitsapp/model/produit.dart';

class ProduitDetails extends StatelessWidget {
  final Produit produit;

  const ProduitDetails({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          produit.libelle!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                produit.photo!,
                height: 160,
                width: 160,
              ),
              const SizedBox(height: 16),
              Text(
                'Prix: ${produit.prix}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'Description: ${produit.description}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/