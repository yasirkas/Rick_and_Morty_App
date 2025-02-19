import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paths.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationPageLoadingCard extends StatelessWidget {
  const LocationPageLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.loadingCardColor,
      margin: StaticMargins.locationDetailsLoadingCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.locationDetailsLoadingCardBorderRadius),
      child: ListTile(
        leading: Image.asset(StaticPaths.loadingBarPath),
        title: Text(
          StaticTexts.loading,
          style: TextStyle(color: StaticColors.loadingTextColor),
        ),
      ),
    );
  }
}