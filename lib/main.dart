import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './pages/homepage.dart';

//GLOBAL VARIABLES
FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignin = GoogleSignIn();
final fbSignin = FacebookAuth.instance;
User? currentUser;
final usersRef = FirebaseFirestore.instance.collection('users');
final storageRef = FirebaseStorage.instance.ref();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(primaryColor: const Color.fromRGBO(55, 106, 237, 1)),
    debugShowCheckedModeBanner: false,
  ));
}
