import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/main_page.dart';
import 'pages/timer_page.dart';
import 'pages/profile_page.dart';
import 'pages/recipe_page.dart';
import 'pages/ingredients_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookMate',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const MainPage(),
        '/timers': (context) => const TimersPage(),
        '/recipes': (context) => const RecipePage(),
        '/ingredients': (context) => const IngredientsPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}