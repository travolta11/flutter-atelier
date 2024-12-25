/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:produitsapp/model/produit.dart';
import 'package:produitsapp/produitsDetails.dart';

class ProduitBox extends StatelessWidget {
  final Produit produit;
  final bool selProduit;
  final Function(bool?)? onChanged;
  Function(BuildContext context)? delProduit;

  ProduitBox(
      {super.key,
      required this.produit,
      this.selProduit = false,
      this.onChanged,
      this.delProduit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: delProduit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(45),
            )
          ]),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProduitDetails(produit: produit),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(45),
              ),
              height: 120,
              child: Row(
                children: [
                  Checkbox(
                    value: selProduit,
                    onChanged: onChanged,
                  ),
                  Center(
                    child: Image.asset(
                      produit.photo!,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(produit.libelle!),
                ],
              ),
            ),
          )),
    );
  }
}
*/