import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationPageNoResidentsCard extends StatelessWidget {
  const LocationPageNoResidentsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.noResidentsCardColor,
      margin: StaticMargins.locationDetailsNoResidentsCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.locationDetailsNoCharactersCardBorderRadius),
      child: ListTile(
        title: Text(
          StaticTexts.noResidentsAvailable,
          style: TextStyle(color: StaticColors.noResidentsAvailableColor),
        ),
      ),
    );
  }
}