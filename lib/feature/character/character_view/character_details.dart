import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
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
        title: Text(character.name ?? ''),
        backgroundColor: StaticColors.characterDetailsBGColor,
        foregroundColor: StaticColors.characterDetailsFGColor,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.characterDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(character.image ?? ''),
            ),
            const SizedBox(height: 12),
            Text(
              character.name ?? '',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: StaticColors.characterDetailsNameColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _infoCard(Icons.person, StaticTexts.species, character.species),
            _infoCard(
                (character.gender == 'Male'
                    ? Icons.male
                    : character.gender == 'Female'
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
      color: Colors.white,
      margin: StaticMargins.characterDetailsMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: StaticColors.characterDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.characterDetailsTitleColor, fontSize: 14),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: StaticColors.characterDetailsSubtitleColor),
        ),
      ),
    );
  }
}
