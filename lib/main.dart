import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './pages/homepage.dart';

//GLOBAL VARIABLES
FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignin = GoogleSignIn();
User? currentUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(primaryColor: const Color.fromRGBO(55, 106, 237, 1)),
    debugShowCheckedModeBanner: false,
  ));
}
