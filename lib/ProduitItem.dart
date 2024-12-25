import 'package:flutter/material.dart';
import 'package:produitsapp/model/produit.dart';

class ProduitItem extends StatelessWidget {
  final Produit produit;
  const ProduitItem({super.key, required this.produit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: produit.image.isNotEmpty
          ? Image.network(
              produit.image,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 50);
              },
            )
          : const Icon(Icons.image_not_supported, size: 50),
      title: Text(produit.designation),
      subtitle: Text(produit.marque),
      trailing: Text("${produit.prix.toStringAsFixed(2)} €"),
    );
  }
}
