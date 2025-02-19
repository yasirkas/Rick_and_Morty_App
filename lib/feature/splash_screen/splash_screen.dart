import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/home_page/home_page.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_paths.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(StaticFontStyle.splashScreenDuration, () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.splashScreenBGColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              StaticPaths.introPath,
              height: StaticFontStyle.splashScreenImageHeight,
            ),
            SizedBox(
                height: StaticFontStyle.splashScreenImageAndTextSpaceBetween),
            Text(StaticTexts.loading,
                style: TextStyle(
                    fontSize: StaticFontStyle.splashScreenTextSize,
                    color: StaticColors.splashScreenTextColor)),
          ],
        ),
      ),
    );
  }
}
