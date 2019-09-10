import 'package:flutter/material.dart';
import 'package:teste_sqlite/pages/lista.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cachorro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Lista(),
    );
  }
}