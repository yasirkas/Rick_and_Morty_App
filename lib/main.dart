import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/home_page_.dart';

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
      home: HomePage(),
    );
  }
}
