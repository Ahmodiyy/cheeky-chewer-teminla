import 'package:cheeky_chewer/screens/Homepage.dart';
import 'package:cheeky_chewer/screens/recipe_instruction.dart';
import 'package:cheeky_chewer/screens/search.dart';
import 'package:cheeky_chewer/screens/forgot_password.dart';
import 'package:cheeky_chewer/screens/info.dart';
import 'package:cheeky_chewer/screens/login.dart';
import 'package:cheeky_chewer/screens/onboard_screen.dart';
import 'package:cheeky_chewer/screens/register.dart';
import 'package:cheeky_chewer/utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = (prefs.getBool('seen') ?? false);
  runApp(
    MyApp(
      showHome: seen,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cheeky Chewer',
      theme: ThemeData(
        appBarTheme: AppBarTheme(),
        scaffoldBackgroundColor: constantAppColorTheme,
        scrollbarTheme: ScrollbarThemeData(
          crossAxisMargin: 5,
          interactive: true,
          isAlwaysShown: true,
          showTrackOnHover: true,
          trackVisibility: MaterialStateProperty.all(true),
          trackColor: MaterialStateProperty.all(
            Color(0xffCB9B4F),
          ),
          thumbColor: MaterialStateProperty.all(
            Color(0xff705832),
          ),
        ),
      ),
      initialRoute: showHome ? Register.id : OnboardScreen.id,
      routes: {
        OnboardScreen.id: (context) => OnboardScreen(),
        Register.id: (context) => Register(),
        Info.id: (context) => Info(),
        Login.id: (context) => Login(),
        Homepage.id: (context) => Homepage(),
        ForgotPassword.id: (context) => ForgotPassword(),
        Search.id: (context) => Search(),
      },
    );
  }
}
