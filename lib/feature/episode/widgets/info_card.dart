import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/constants/static_colors.dart';
import 'package:rick_and_morty_app/product/constants/static_font_style.dart';
import 'package:rick_and_morty_app/product/constants/static_margins.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

class EpisodePageInfoCard extends StatelessWidget {
  const EpisodePageInfoCard(
      {super.key, required this.icon, required this.title, this.value});
  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.episodeDetailsInfoCardBGColor,
      margin: StaticMargins.episodeDetailsInfoCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius: StaticFontStyle.episodeDetailInfoCardBorderRadius),
      child: ListTile(
        leading: Icon(icon, color: StaticColors.episodeDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.episodeDetailsTitleColor,
              fontSize: StaticFontStyle.episodeDetailInfoCardTitleSize),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: StaticFontStyle.episodeDetailInfoCardSubtitleSize,
              fontWeight:
                  StaticFontStyle.episodeDetailInfoCardSubtitleFontWeight,
              color: StaticColors.episodeDetailsSubtitleColor),
        ),
      ),
    );
  }
}
