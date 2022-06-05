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
      title: 'FashCoP',
      debugShowCheckedModeBanner: false,
      initialRoute: FinalSignUpScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        FirstSignUpScreen.id: (context) => FirstSignUpScreen(),
        SecondSignUpScreen.id: (context) => SecondSignUpScreen(),
        FinalSignUpScreen.id: (context) => FinalSignUpScreen(),
      },
    );
  }
}
