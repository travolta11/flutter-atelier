import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final User? user = FirebaseAuth.instance.currentUser; 
   void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Informations:", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            if (user != null) ...[
              Text("Email: ${user!.email ?? "Aucun Email n'est trouvé "}"),
              SizedBox(height: 10),
            ],
            ElevatedButton(
              onPressed: () => logout(context),
              child: Text("Déconnection"),
            ),
          ],
        ),
      ),
    );
  }
}