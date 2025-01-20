import 'package:flutter/material.dart';
import 'package:project_nexus/about.dart';
import 'package:project_nexus/fav.dart';
import 'package:project_nexus/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> widgets = [
    HomePage(),
    Fav(),
    About(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: const Color.fromARGB(255, 140, 102, 228),
        unselectedItemColor: Colors.white,
      ),
    );
  }
}
