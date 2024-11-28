import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'produits_list.dart';

void main() {
  runApp(const MainApp());
  
  Firebase.initializeApp();
 
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProduitsList(),
    );
  }
}
