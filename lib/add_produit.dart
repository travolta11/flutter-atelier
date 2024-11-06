import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AddProduit extends StatefulWidget {
  final TextEditingController nomController;
  final TextEditingController descriptionController;
  final TextEditingController prixController;
  final void Function(String imageBase64)? onAdd;
  final void Function()? onCancel;

  const AddProduit({
    super.key,
    required this.nomController,
    required this.descriptionController,
    required this.prixController,
    required this.onAdd,
    required this.onCancel,
  });

  @override
  _AddProduitState createState() => _AddProduitState();
}

class _AddProduitState extends State<AddProduit> {
  File? _image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String encodeImageToBase64(File image) {
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter un produit"),
      content: SizedBox(
        height: 300,
        child: Column(
          children: [
            TextField(
              controller: widget.nomController,
              decoration: const InputDecoration(labelText: 'Nom du produit'),
            ),
            TextField(
              controller: widget.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: widget.prixController,
              decoration: const InputDecoration(labelText: 'Prix'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Choisir une image'),
            ),
            if (_image != null) Image.file(_image!, width: 100, height: 100),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_image != null) {
              final imageBase64 = encodeImageToBase64(_image!);
              widget.onAdd?.call(imageBase64);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Ajouter'),
        ),
        TextButton(
          onPressed: widget.onCancel,
          child: const Text("Annuler"),
        ),
      ],
    );
  }
}
