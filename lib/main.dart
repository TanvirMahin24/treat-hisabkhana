import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const Home(),
    theme: ThemeData(primaryColor: const Color.fromRGBO(55, 106, 237, 1)),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'Hello world',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
