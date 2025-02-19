import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class EpisodePageCharacterCard extends StatelessWidget {
  const EpisodePageCharacterCard({super.key, required this.character});
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.episodeDetailsCharacterCardColor,
      elevation: StaticFontStyle.episodeDetailsCharacterCardElevation,
      margin: StaticMargins.episodeDetailsCharacterCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.episodeDetailsCharacterCardBorderRadius),
      child: ListTile(
        leading: CircleAvatar(
          radius: StaticFontStyle.episodeDetailsCharacterCardCircleAvatarRadius,
          backgroundImage:
              NetworkImage(character.image ?? StaticTexts.noDataError),
        ),
        title: Text(
          character.name ?? StaticTexts.noDataError,
          style: TextStyle(
              color: StaticColors.episodeDetailsCharacterNameColor,
              fontSize: StaticFontStyle.episodeDetailsCharacterNameSize,
              fontWeight:
                  StaticFontStyle.episodeDetailsCharacterNameFontWeight),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: StaticFontStyle.episodeDetailsIconsCircleSize,
              color: (character.status == StaticTexts.alive)
                  ? StaticColors.characterAliveColor
                  : (character.status == StaticTexts.dead)
                      ? StaticColors.characterDeadColor
                      : StaticColors.characterUnknownColor,
            ),
            SizedBox(
                width: StaticFontStyle
                    .episodeDetailsIconsCircleAndSubtitleSpaceBetween),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors.episodeDetailsCharacterSubtitleColor,
                  fontSize:
                      StaticFontStyle.episodeDetailsCharacterCardSubtitleSize),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CharacterDetails(character: character),
            ),
          );
        },
      ),
    );
  }
}
