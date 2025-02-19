import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class LocationPageCharacterCard extends StatelessWidget {
  const LocationPageCharacterCard({super.key, required this.character});
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: StaticColors.locationDetailsCharacterCardColor,
      elevation: StaticFontStyle.locationDetailsCharacterCardElevation,
      margin: StaticMargins.locationDetailsCharacterCardMargin,
      shape: RoundedRectangleBorder(
          borderRadius:
              StaticFontStyle.locationDetailsCharacterCardBorderRadius),
      child: ListTile(
        leading: CircleAvatar(
          radius:
              StaticFontStyle.locationDetailsCharacterCardCircleAvatarRadius,
          backgroundImage:
              NetworkImage(character.image ?? StaticTexts.noDataError),
        ),
        title: Text(
          character.name ?? StaticTexts.noDataError,
          style: TextStyle(
              color: StaticColors.locationDetailsCharacterNameColor,
              fontSize: StaticFontStyle.locationDetailsCharacterNameSize,
              fontWeight:
                  StaticFontStyle.locationDetailsCharacterNameFontWeight),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: StaticFontStyle.locationDetailsIconsCircleSize,
              color: (character.status == StaticTexts.alive)
                  ? StaticColors.characterAliveColor
                  : (character.status == StaticTexts.dead)
                      ? StaticColors.characterDeadColor
                      : StaticColors.characterUnknownColor,
            ),
            SizedBox(
                width: StaticFontStyle
                    .locationDetailsIconsCircleAndSubtitleSpaceBetween),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors.locationDetailsCharacterSubtitleColor,
                  fontSize:
                      StaticFontStyle.locationDetailsCharacterCardSubtitleSize),
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
