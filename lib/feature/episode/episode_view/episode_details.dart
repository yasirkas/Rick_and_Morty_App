import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_details.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/episode_model/episode_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_margins.dart';
import 'package:rick_and_morty_app/product/contains/static_paddings.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class EpisodeDetails extends StatelessWidget {
  EpisodeDetails({super.key, required this.episode});
  final Episodes episode;
  final Service _service = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StaticColors.episodeDetailsGeneralBGColor,
      appBar: AppBar(
        title: Text(
          episode.name ?? '',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: StaticColors.episodeDetailsBGColor,
        foregroundColor: StaticColors.episodeDetailsFGColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.episodeDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoCard(
                Icons.calendar_today, StaticTexts.airDate, episode.airDate),
            _infoCard(
                Icons.video_library, StaticTexts.episode, episode.episode),
            const SizedBox(height: 16),
            Text(
              StaticTexts.characters,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: StaticColors.charactersColor,
              ),
            ),
            const SizedBox(height: 10),
            if (episode.characters == null || episode.characters!.isEmpty)
              _noCharactersCard()
            else
              ...episode.characters!.map((characterUrl) {
                return FutureBuilder<CharacterModel?>(
                  future: _service.getCharacter(characterUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _loadingCard();
                    } else {
                      final character = snapshot.data!;
                      return _characterCard(context, character);
                    }
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String? value) {
    return Card(
      color: StaticColors.episodeDetailsInfoCardBGColor,
      margin: StaticMargins.episodeDetailsInfoCardMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: StaticColors.episodeDetailsIconColor),
        title: Text(
          title,
          style: TextStyle(
              color: StaticColors.episodeDetailsTitleColor, fontSize: 14),
        ),
        subtitle: Text(
          value ?? StaticTexts.unknown,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: StaticColors.episodeDetailsSubtitleColor),
        ),
      ),
    );
  }

  Widget _characterCard(BuildContext context, CharacterModel character) {
    return Card(
      color: StaticColors.episodeDetailsCharacterCardColor,
      elevation: 2,
      margin: StaticMargins.episodeDetailsCharacterCardMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(character.image ?? ''),
        ),
        title: Text(
          character.name ?? '',
          style: TextStyle(
              color: StaticColors.episodeDetailsCharacterNameColor,
              fontSize: 18),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.circle,
              size: 12,
              color: (character.status == 'Alive')
                  ? StaticColors.characterAliveColor
                  : (character.status == 'Dead')
                      ? StaticColors.characterDeadColor
                      : StaticColors.characterUnknownColor,
            ),
            const SizedBox(width: 6),
            Text(
              '${character.status} - ${character.species}',
              style: TextStyle(
                  color: StaticColors.episodeDetailsCharacterSubtitleColor,
                  fontSize: 14),
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

  Widget _loadingCard() {
    return Card(
      color: StaticColors.loadingCardColor,
      margin: StaticMargins.episodeDetailsLoadingCardMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Image.asset('assets/gif/portal_loading.gif'),
        title: Text(
          StaticTexts.loading,
          style: TextStyle(color: StaticColors.loadingTextColor),
        ),
      ),
    );
  }

  Widget _noCharactersCard() {
    return Card(
      color: StaticColors.noCharactersCardColor,
      margin: StaticMargins.episodeDetailsNoCharacterCardMargin,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          StaticTexts.noCharactersAvailable,
          style: TextStyle(color: StaticColors.noCharactersAvailableColor),
        ),
      ),
    );
  }
}
