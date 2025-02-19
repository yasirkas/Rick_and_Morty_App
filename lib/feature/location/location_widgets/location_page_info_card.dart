import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationPageInfoCard extends StatelessWidget {
  const LocationPageInfoCard(
      {super.key, required this.icon, required this.title, this.value});
  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.locationDetailsInfoCardBGColor,
      margin: StaticMargins.locationDetailsInfoCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.locationDetailInfoCardBorderRadius),
      child: ListTile(
        leading: Icon(icon, color: StaticColors.locationDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.locationDetailsTitleColor,
              fontSize: StaticFontStyle.locationDetailInfoCardTitleSize),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: StaticFontStyle.locationDetailInfoCardSubtitleSize,
              fontWeight:
                  StaticFontStyle.locationDetailInfoCardSubtitleFontWeight,
              color: StaticColors.locationDetailsSubtitleColor),
        ),
      ),
    );
  }
}
