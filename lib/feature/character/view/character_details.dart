import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/model/character_model.dart';
import 'package:rick_and_morty_app/feature/character/widgets/info_card.dart';
import 'package:rick_and_morty_app/product/constants/static_colors.dart';
import 'package:rick_and_morty_app/product/constants/static_font_style.dart';
import 'package:rick_and_morty_app/product/constants/static_paddings.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

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
              backgroundImage:
                  NetworkImage(character.image ?? StaticTexts.noDataError),
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
            CharacterInfoCard(
              icon: Icons.person,
              title: StaticTexts.species,
              value: character.species,
            ),
            CharacterInfoCard(
              icon: (character.gender == StaticTexts.male
                  ? Icons.male
                  : character.gender == StaticTexts.female
                      ? Icons.female
                      : Icons.question_mark),
              title: StaticTexts.gender,
              value: character.gender,
            ),
            CharacterInfoCard(
              icon: Icons.location_on,
              title: StaticTexts.location,
              value: character.location?.name,
            ),
            CharacterInfoCard(
                icon: Icons.public,
                title: StaticTexts.origin,
                value: character.origin?.name),
            CharacterInfoCard(
                icon: Icons.tv,
                title: StaticTexts.episodes,
                value: character.episode?.length.toString()),
          ],
        ),
      ),
    );
  }
}
