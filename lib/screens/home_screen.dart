import 'package:fashcop/screens/add_project_screen.dart';
import 'package:fashcop/screens/favourite_screen.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    HomePage(),
    FavouriteScreen(),
    AddProductScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        onTabChange: _navBarTapped,
        gap: 8,
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        activeColor: Color(0xff5ac18e),
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[200]!,
        color: Colors.black45,
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.favorite_border, text: 'Favorites'),
          GButton(icon: Icons.add_rounded, text: 'Add'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}
