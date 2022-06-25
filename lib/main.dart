import 'package:fashcop/components/signup_data.dart';
import 'package:fashcop/models/favorite_provider.dart';
import 'package:fashcop/screens/another_users_profile.dart';
import 'package:fashcop/screens/home_screen.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/profile_screen.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:fashcop/screens/login_screen.dart';
import 'package:fashcop/screens/first_signup_screen.dart';
import 'package:fashcop/screens/second_signup_screen.dart';
import 'package:fashcop/screens/final_signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignupFormData(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
      ],
      child: MaterialApp(
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
        // initialRoute: HomeScreen.id,
        initialRoute: SplashScreen.splashSCreenId,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          FirstSignUpScreen.id: (context) => FirstSignUpScreen(),
          SecondSignUpScreen.id: (context) => SecondSignUpScreen(),
          FinalSignUpScreen.id: (context) => FinalSignUpScreen(),
          SplashScreen.splashSCreenId: (context) => const SplashScreen(),
          //AnotherUsersProfile.id: (context) => AnotherUsersProfile(),
          //ProfileScreen.id: (context) => ProfileScreen(),
          //SingleProjectScreen.id: (context) => SingleProjectScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == SingleProjectScreen.id) {
            final ProductArguments args =
                settings.arguments as ProductArguments;
            return MaterialPageRoute(builder: (context) {
              return SingleProjectScreen(
                productId: args.productId,
                userId: args.userId,
              );
            });
          } else if (settings.name == AnotherUsersProfile.id) {
            final ProjectOwnerArguments args =
                settings.arguments as ProjectOwnerArguments;
            return MaterialPageRoute(builder: (context) {
              return AnotherUsersProfile(
                userId: args.userId,
              );
            });
          }
          return null;
        },
      ),
    );
  }
}
