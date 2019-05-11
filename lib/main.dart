import 'package:flutter/material.dart';
import 'menu.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Color.fromRGBO(39, 174, 97, 1.0),
        child: Solver(),
      ),
    );
  }
}