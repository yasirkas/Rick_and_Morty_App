import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_details.dart';
import 'package:rick_and_morty_app/feature_product/character/character_model.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_model.dart';
import 'package:rick_and_morty_app/feature_product/service/service.dart';

class EpisodeDetails extends StatelessWidget {
  EpisodeDetails({super.key, required this.episode});
  final Episodes episode;
  final Service _service = Service();

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
              SizedBox(height: 16),
              Text(
                'Characters:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...episode.characters!.map((characterUrl) {
                return FutureBuilder<CharacterModel?>(
                  future: _service.getCharacter(characterUrl),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListTile(
                        leading: CircularProgressIndicator(),
                        title: Text('Loading...'),
                      );
                    } else if (snapshot.hasError) {
                      return ListTile(
                        title: Text('Error loading character'),
                      );
                    } else if (!snapshot.hasData) {
                      return ListTile(
                        title: Text('No data available'),
                      );
                    } else {
                      final character = snapshot.data!;
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(character.image ?? ''),
                          ),
                          title: Text(character.name ?? ''),
                          subtitle: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 12,
                                color: (character.status == 'Alive')
                                    ? Colors.green
                                    : (character.status == 'Dead')
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                              Text(
                                  '${character.status} - ${character.species}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CharacterDetails(character: character),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
