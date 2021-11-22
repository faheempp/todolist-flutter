import 'package:flutter/material.dart';
import 'package:todo_app/UI/home.dart';
import 'package:todo_app/UI/Utils/theme.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        fontFamily: primaryFont,
        primaryColor: blue,
      ),
    );
  }
}
