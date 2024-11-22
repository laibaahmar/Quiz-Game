import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      home: HomeScreen(),
      theme:ThemeData(appBarTheme: AppBarTheme(foregroundColor: Colors.white)),
      debugShowCheckedModeBanner: false,
    );
  }
}