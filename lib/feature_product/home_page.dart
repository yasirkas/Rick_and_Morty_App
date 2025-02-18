import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/feature_product/character/character_page.dart';
import 'package:rick_and_morty_app/feature_product/episode/episode_page.dart';
import 'package:rick_and_morty_app/feature_product/location/location_page.dart';

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
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/locations_icon.png',
                width: 30,
              ),
              label: 'Locations',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icon/episodes_icon.png',
                width: 30,
              ),
              label: 'Episodes',
            ),
          ]),
    );
  }
}
