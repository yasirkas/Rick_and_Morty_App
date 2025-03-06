import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/costants/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/episode_view/episode_details.dart';
import 'package:rick_and_morty_app/feature/episode/episode_model/episode_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/costants/static_font_style.dart';
import 'package:rick_and_morty_app/product/costants/static_margins.dart';
import 'package:rick_and_morty_app/product/costants/static_paddings.dart';
import 'package:rick_and_morty_app/product/costants/static_paths.dart';
import 'package:rick_and_morty_app/product/utility/loading_mixin.dart';
import 'package:rick_and_morty_app/product/costants/static_texts.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage>
    with LoadingMixin<EpisodePage> {
  List<Episodes>? _episodes;
  final Service _service = Service();

  @override
  void initState() {
    super.initState();
    getEpisodes();
  }

  Future<void> getEpisodes() async {
    changeLoading();
    _episodes = await _service.getEpisodes();
    changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: StaticColors.episodePageFGColor,
        title: Text(StaticTexts.episodesPageTitle),
        backgroundColor: StaticColors.episodePageBGColor,
      ),
      body: isLoading
          ? Center(child: Image.asset(StaticPaths.loadingBarPath))
          : _episodes == null
              ? Center(child: Text(StaticTexts.noEpisodesFound))
              : ListView.builder(
                  padding: StaticPaddings.episodeListViewBuilderPadding,
                  itemCount:
                      _episodes?.length ?? StaticFontStyle.errorLength,
                  itemBuilder: (context, index) {
                    final episode = _episodes?[index];
                    return Card(
                      elevation: StaticFontStyle.episodePageCardElevation,
                      margin: StaticMargins.episodePageMargin,
                      child: ListTile(
                        contentPadding:
                            StaticPaddings.episodePageContendtPadding,
                        leading: Icon(
                          Icons.movie_creation,
                          size: StaticFontStyle.episodePageCardIconSize,
                          color: StaticColors.episodePageIconColor,
                        ),
                        title: Text(
                          episode?.name ?? StaticTexts.noDataError,
                          style: TextStyle(
                            color: StaticColors.episodePageNameColor,
                            fontWeight: StaticFontStyle.episodePageCardTitleFontWeight,
                            fontSize: StaticFontStyle.episodePageCardTitleSize,
                          ),
                        ),
                        subtitle: Text(
                          episode?.episode ?? StaticTexts.noEpisodeAvailable,
                          style: TextStyle(
                              color: StaticColors.episodePageSubtitleColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: StaticFontStyle.episodePageCardArrowSize,
                          color: StaticColors.episodePageArrowColor,
                        ),
                        onTap: () {
                          if (episode != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EpisodeDetails(episode: episode),
                            ));
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
