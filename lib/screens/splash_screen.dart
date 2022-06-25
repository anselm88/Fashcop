import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/home_screen.dart';
import 'package:fashcop/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const splashSCreenId = "/splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _navigateToNextScreen();
    defaultScreen();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(Duration(seconds: 8), () {});
    // Navigator.pushReplacementNamed(context, '/home');
  }

  Stream<String>? _stream;

  void defaultScreen() async {
    debugPrint("dhalsld");
    _stream = FirebaseAuth.instance
        .authStateChanges()
        .asyncMap(
          (user) => FirebaseFirestore.instance
              .collection('users')
              .doc(user?.uid)
              .get(),
        )
        .map(
      (doc) {
        var accountType = doc.data()!['accountType'];
        debugPrint("Account type gotten....: $accountType");
        if (accountType == "FARMER") {
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        } else {
          Navigator.pushReplacementNamed(context, LoginScreen.id);
        }
        return accountType;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String>(
        stream: _stream,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.done) {
          //   String accountType = snapshot.data!;
          //   if (accountType == "FARMER") {
          //     Navigator.pushReplacementNamed(context, HomeScreen.id);
          //   } else {
          //     Navigator.pushReplacementNamed(context, LoginScreen.id);
          //   }
          // }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  'FaSHCoP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff5ac18e),
                  ),
                ),
              ),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xff5ac18e),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
