import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_model/character_model.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_character_card.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_info_card.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_loading_card.dart';
import 'package:rick_and_morty_app/feature/episode/episode_widgets/episode_page_no_characters_card.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/episode_model/episode_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/contains/static_font_style.dart';
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
          episode.name ?? StaticTexts.noDataError,
          style: TextStyle(
              fontWeight: StaticFontStyle.episodeDetailsPageTitleFontWeight),
        ),
        backgroundColor: StaticColors.episodeDetailsBGColor,
        foregroundColor: StaticColors.episodeDetailsFGColor,
        elevation: StaticFontStyle.episodeDetailsPageElevation,
      ),
      body: SingleChildScrollView(
        padding: StaticPaddings.episodeDetailsBodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EpisodePageInfoCard(
              icon: Icons.calendar_today,
              title: StaticTexts.airDate,
              value: episode.airDate,
            ),
            EpisodePageInfoCard(
              icon: Icons.video_library,
              title: StaticTexts.episode,
              value: episode.episode,
            ),
            SizedBox(
                height:
                    StaticFontStyle.episodeDetailsInfoCardAndTitleSpaceBetween),
            Text(
              StaticTexts.characters,
              style: TextStyle(
                fontSize: StaticFontStyle.episodeDetailCharactersTitleSize,
                fontWeight:
                    StaticFontStyle.episodeDetailCharactersTitleFontWeight,
                color: StaticColors.charactersColor,
              ),
            ),
            SizedBox(
                height: StaticFontStyle.episodeDetailTitleAndCardsSpaceBetween),
            if (episode.characters == null || episode.characters!.isEmpty)
              EpisodePageNoCharactersCard()
            else
              ...episode.characters!.map((characterUrl) {
                return FutureBuilder<CharacterModel?>(
                  future: _service.getCharacter(characterUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return EpisodePageLoadingCard();
                    } else {
                      final character = snapshot.data!;
                      return EpisodePageCharacterCard(character: character);
                    }
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

}
