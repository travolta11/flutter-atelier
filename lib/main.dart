import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:produitsapp/firebase_options.dart';
import 'package:produitsapp/login_ecran.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(const MainApp());
  
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routes: {
        '/login': (context) => LoginEcran(),
      },
      initialRoute: '/login',
        );
  }
}
