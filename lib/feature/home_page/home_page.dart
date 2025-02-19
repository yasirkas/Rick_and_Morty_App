import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/character_view/character_page.dart';
import 'package:rick_and_morty_app/feature/episode/episode_view/episode_page.dart';
import 'package:rick_and_morty_app/feature/location/location_view/location_page.dart';
import 'package:rick_and_morty_app/product/contains/static_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    CharacterPage(),
    LocationPage(),
    EpisodePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/characters_icon.png',
                width: 30,
              ),
              label: StaticTexts.navCharacters,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/locations_icon.png',
                width: 30,
              ),
              label: StaticTexts.navLocations,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/episodes_icon.png',
                width: 30,
              ),
              label: StaticTexts.navEpisodes,
            ),
          ]),
    );
  }
}
