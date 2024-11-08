import 'package:aami/views/home/cart_page.dart';
import 'package:aami/views/home/favourite_page.dart';
import 'package:aami/views/home/home_page.dart';
import 'package:aami/views/home/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavBarPage extends StatefulWidget {
  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  int _selectedIndex = 0;

  // List of pages to display based on the selected index
  final List<Widget> _pages = [
    HomePage(),
    FavouritePage(),
    CartPage(),
    ProfilePage(),
  ];

  // Function to handle item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        elevation: 3,

        // Center the icons and adjust spacing
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedIndex != 0) Icon(Icons.home_outlined),
              ],
            ),
            label: _selectedIndex == 0 ? 'Home' : '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedIndex != 1) Icon(Icons.favorite_outline),
              ],
            ),
            label: _selectedIndex == 1 ? 'Favourite' : '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedIndex != 2) Icon(Icons.shopping_bag_outlined),
              ],
            ),
            label: _selectedIndex == 2 ? 'Cart' : '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_selectedIndex != 3) Icon(Icons.person_outline),
              ],
            ),
            label: _selectedIndex == 3 ? 'Profile' : '',
          ),
        ],
      ),
    );
  }
}
