import 'package:fashcop/screens/home_screen.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fashcop/screens/login_screen.dart';
import 'package:fashcop/screens/first_signup_screen.dart';
import 'package:fashcop/screens/second_signup_screen.dart';
import 'package:fashcop/screens/final_signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.white,
          onPrimary: Colors.white,
          primaryContainer: Colors.black,
          secondaryContainer: Colors.white70,
          surface: Color(0xffffffff),
          onSurface: Color(0xffffffff),
          background: Color(0xffffffff),
          onBackground: Color(0xffffffff),
          brightness: Brightness.light,
          onError: Color(0xffb00020),
          secondary: Colors.white70,
          onSecondary: Colors.white70,
          error: Color(0xffb00020),
        ),
      ),
      title: 'FashCoP',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        FirstSignUpScreen.id: (context) => FirstSignUpScreen(),
        SecondSignUpScreen.id: (context) => SecondSignUpScreen(),
        FinalSignUpScreen.id: (context) => FinalSignUpScreen(),
      },
    );
  }
}
