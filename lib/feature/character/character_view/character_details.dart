import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paddings.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({super.key, required this.character});
  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.characterDetailsGeneralBGColor,
      appBar: AppBar(
        title: Text(character.name ?? StaticTexts.noDataError),
        backgroundColor: StaticColors.characterDetailsBGColor,
        foregroundColor: StaticColors.characterDetailsFGColor,
        elevation: StaticFontStyle.characterDetailsPageElevation,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.characterDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: StaticFontStyle.characterCircleAvatarRadius,
              backgroundImage: NetworkImage(character.image ?? StaticTexts.noDataError),
            ),
            SizedBox(height: StaticFontStyle.characterAndTitleSpaceBetween),
            Text(
              character.name ?? StaticTexts.noDataError,
              style: TextStyle(
                fontSize: StaticFontStyle.characterPageNameSize,
                fontWeight: StaticFontStyle.characterPageNameFontWeight,
                color: StaticColors.characterDetailsNameColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height: StaticFontStyle.characterPageNameAndCardSpaceBetween),
            _infoCard(Icons.person, StaticTexts.species, character.species),
            _infoCard(
                (character.gender == StaticTexts.male
                    ? Icons.male
                    : character.gender == StaticTexts.female
                        ? Icons.female
                        : Icons.question_mark),
                StaticTexts.gender,
                character.gender),
            _infoCard(Icons.location_on, StaticTexts.location,
                character.location?.name),
            _infoCard(Icons.public, StaticTexts.origin, character.origin?.name),
            _infoCard(Icons.tv, StaticTexts.episodes,
                character.episode?.length.toString()),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String? value) {
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
