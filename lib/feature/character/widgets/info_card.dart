import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/constants/static_colors.dart';
import 'package:rick_and_morty_app/product/constants/static_font_style.dart';
import 'package:rick_and_morty_app/product/constants/static_margins.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

class CharacterInfoCard extends StatelessWidget {
  const CharacterInfoCard(
      {super.key, required this.icon, required this.title, this.value});
  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.characterDetailsInfoCardBGColor,
      margin: StaticMargins.characterDetailsMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.characterDetailsInfoCardBorderRadius),
      elevation: StaticFontStyle.characterDetailsPageInfoCardElevation,
      child: ListTile(
        leading: Icon(icon, color: StaticColors.characterDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.characterDetailsTitleColor,
              fontSize: StaticFontStyle.characterDetailsTitleSize),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: StaticFontStyle.characterDetailsSubtitleSize,
              fontWeight: StaticFontStyle.characterDetailsSubtitleFontWeight,
              color: StaticColors.characterDetailsSubtitleColor),
        ),
      ),
    );
  }
}
