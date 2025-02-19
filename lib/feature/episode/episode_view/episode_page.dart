import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/product/contains/static_colors.dart';
import 'package:rick_and_morty_app/feature/episode/episode_view/episode_details.dart';
import 'package:rick_and_morty_app/feature/episode/episode_model/episode_model.dart';
import 'package:rick_and_morty_app/feature/service/service.dart';
import 'package:rick_and_morty_app/product/utility/loading_mixin.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

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
        foregroundColor: StaticColors().episodePageFGColor,
        title: Text(StaticTexts().episodesPageTitle),
        backgroundColor: StaticColors().episodePageBGColor,
      ),
      body: isLoading
          ? Center(child: Image.asset('assets/gif/portal_loading.gif'))
          : _episodes == null
              ? Center(child: Text(StaticTexts().noEpisodesFound))
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _episodes?.length ?? 0,
                  itemBuilder: (context, index) {
                    final episode = _episodes?[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: Icon(
                          Icons.movie_creation,
                          size: 40,
                          color: StaticColors().episodePageIconColor,
                        ),
                        title: Text(
                          episode?.name ?? '',
                          style: TextStyle(
                            color: StaticColors().episodePageNameColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          episode?.episode ?? StaticTexts().noEpisodeAvailable,
                          style: TextStyle(
                              color: StaticColors().episodePageSubtitleColor),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: StaticColors().episodePageArrowColor,
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
