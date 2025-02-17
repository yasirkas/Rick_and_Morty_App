import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';

class EpisodeDetails extends StatelessWidget {
  const EpisodeDetails({super.key, required this.episode});
  final Episodes episode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name ?? ''),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('AirDate: ${episode.airDate}'),
              Text('Episode: ${episode.episode}'),
              Text('Characters: ${episode.characters}'),
            ],
          ),
        ),
      ),
    );
  }
}
