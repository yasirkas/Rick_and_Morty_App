import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/pages/character/character_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty App',
      theme: ThemeData.light(),
      home: CharacterPage(),
    );
  }
}
