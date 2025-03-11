import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/splash_screen/splash_screen.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StaticTexts.mainTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}
