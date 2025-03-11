import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature/character/view/character_home.dart';
import 'package:rick_and_morty_app/feature/episode/view/episode_home.dart';
import 'package:rick_and_morty_app/feature/location/view/location_home.dart';
import 'package:rick_and_morty_app/product/constants/static_colors.dart';
import 'package:rick_and_morty_app/product/constants/static_font_style.dart';
import 'package:rick_and_morty_app/product/constants/static_paths.dart';
import 'package:rick_and_morty_app/product/constants/static_texts.dart';

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
          backgroundColor: StaticColors.navigationBarBGColor,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                StaticPaths.navCharactersIconPath,
                width: StaticFontStyle.homePageIconWidth,
              ),
              label: StaticTexts.navCharacters,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                StaticPaths.navLocationsIconPath,
                width: StaticFontStyle.homePageIconWidth,
              ),
              label: StaticTexts.navLocations,
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                StaticPaths.navEpisodesIconPath,
                width: StaticFontStyle.homePageIconWidth,
              ),
              label: StaticTexts.navEpisodes,
            ),
          ]),
    );
  }
}
