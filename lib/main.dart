import 'package:flutter/material.dart';
import './pages/homepage.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(primaryColor: const Color.fromRGBO(55, 106, 237, 1)),
    debugShowCheckedModeBanner: false,
  ));
}
