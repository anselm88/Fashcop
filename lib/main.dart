import 'package:flutter/material.dart';
import 'package:fashcop/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FashCoP',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
