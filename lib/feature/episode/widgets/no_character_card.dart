import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/costants/static_colors.dart';
import 'package:rick_and_morty_app/product/costants/static_font_style.dart';
import 'package:rick_and_morty_app/product/costants/static_margins.dart';
import 'package:rick_and_morty_app/product/costants/static_texts.dart';

class EpisodePageNoCharactersCard extends StatelessWidget {
  const EpisodePageNoCharactersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.noCharactersCardColor,
      margin: StaticMargins.episodeDetailsNoCharacterCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.episodeDetailsNoCharactersCardBorderRadius),
      child: ListTile(
        title: Text(
          StaticTexts.noCharactersAvailable,
          style: TextStyle(color: StaticColors.noCharactersAvailableColor),
        ),
      ),
    );
  }
}