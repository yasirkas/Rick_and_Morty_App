import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paths.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class EpisodePageLoadingCard extends StatelessWidget {
  const EpisodePageLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.loadingCardColor,
      margin: StaticMargins.episodeDetailsLoadingCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.episodeDetailsLoadingCardBorderRadius),
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