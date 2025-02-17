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
        title: const Text("Episodes"),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? Center(child: Image.asset('assets/gif/portal_loading.gif'))
          : _episodes == null
              ? Center(child: Text('No episodes found.'))
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
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          episode?.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle:
                            Text(episode?.airDate ?? 'No air date available'),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.blueAccent,
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
