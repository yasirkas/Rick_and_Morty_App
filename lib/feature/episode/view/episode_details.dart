import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/model/character_model.dart';
import 'package:rick_and_morty_app/feature/episode/widgets/character_card.dart';
import 'package:rick_and_morty_app/feature/episode/widgets/info_card.dart';
import 'package:rick_and_morty_app/feature/episode/widgets/loading_card.dart';
import 'package:rick_and_morty_app/feature/episode/widgets/no_character_card.dart';
import 'package:rick_and_morty_app/product/costants/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/model/episode_model.dart';
import 'package:rick_and_morty_app/product/service/service.dart';
import 'package:rick_and_morty_app/product/costants/static_font_style.dart';
import 'package:rick_and_morty_app/product/costants/static_paddings.dart';
import 'package:rick_and_morty_app/product/costants/static_texts.dart';

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
      body: ListView.builder(
        padding: StaticPaddings.episodeDetailsBodyPadding,
        itemCount: (episode.characters == null || episode.characters!.isEmpty)
            ? 4 // Info cards + Title + No Characters Card
            : (episode.characters!.length +
                3), // Info cards + Title + Characters
        itemBuilder: (context, index) {
          if (index == 0) {
            return EpisodePageInfoCard(
              icon: Icons.calendar_today,
              title: StaticTexts.airDate,
              value: episode.airDate,
            );
          } else if (index == 1) {
            return EpisodePageInfoCard(
              icon: Icons.video_library,
              title: StaticTexts.episode,
              value: episode.episode,
            );
          } else if (index == 2) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: StaticFontStyle
                        .episodeDetailsInfoCardAndTitleSpaceBetween),
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
                    height:
                        StaticFontStyle.episodeDetailTitleAndCardsSpaceBetween),
              ],
            );
          } else if (episode.characters == null ||
              episode.characters!.isEmpty) {
            return EpisodePageNoCharactersCard();
          } else {
            final characterUrl = episode.characters![index - 3];
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
          }
        },
      ),
    );
  }
}
