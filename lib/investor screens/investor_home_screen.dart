import 'package:fashcop/investor%20screens/investor_home_page.dart';
import 'package:fashcop/investor%20screens/investor_profile.dart';
import 'package:fashcop/investor%20screens/recomended_project.dart';
import 'package:fashcop/screens/add_project_screen.dart';
import 'package:fashcop/screens/favourite_screen.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/profile_screen.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class InvestorHomeScreen extends StatefulWidget {
  static const String id = 'investor_home_screen';
  const InvestorHomeScreen({Key? key}) : super(key: key);

  @override
  State<InvestorHomeScreen> createState() => _InvestorHomeScreenState();
}

class _InvestorHomeScreenState extends State<InvestorHomeScreen> {
  int _selectedIndex = 0;

  void _navBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pages = [
    InvestorHomePage(),
    RecomendedProjects(),
    InvestorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBody: true,
      //extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              ),
          brightness: Brightness.light,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //borderRadius: const BorderRadius.only(
              //bottomLeft: Radius.circular(30),
              //bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  Colors.white30,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            "FaSHCoP",
            style: kHeadingStyle,
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        onTabChange: _navBarTapped,
        gap: 8,
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        activeColor: Color(0xff5ac18e),
        iconSize: 30,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[200]!,
        color: Colors.black45,
        tabs: [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.recommend, text: 'Recommended'),
          GButton(icon: Icons.person, text: 'Profile'),
        ],
      ),
    );
  }
}
