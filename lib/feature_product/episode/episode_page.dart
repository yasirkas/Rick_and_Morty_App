import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_details.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';
import 'package:rick_and_morty_app/feature_product/utility/loading_mixin.dart';

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
        foregroundColor: Colors.white,
        title: Text("Episodes Page"),
        backgroundColor: Colors.blueAccent,
        actions: [
          isLoading ? CircularProgressIndicator.adaptive() : SizedBox.shrink()
        ],
      ),
      body: ListView.builder(
        itemCount: _episodes?.length ?? 0,
        itemBuilder: (context, index) {
          final episode = _episodes?[index];
          return ListTile(
            title: Text(episode?.name ?? ''),
            onTap: () {
              if (episode != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EpisodeDetails(episode: episode),
                ));
              }
            },
          );
        },
      ),
    );
  }
}
