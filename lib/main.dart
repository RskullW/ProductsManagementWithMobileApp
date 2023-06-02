import 'package:flutter/material.dart';
import 'add_screen.dart';
import 'display_screen.dart';
import 'find_screen.dart';
import 'home_screen.dart';
import 'remove_screen.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MediaQuery(
        data: MediaQueryData(),
        child: SplashScreen(),
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/add': (context) => AddScreen(),
        '/remove': (context) => RemoveScreen(),
        '/find': (context) => FindScreen(),
        '/display': (context) => DisplayScreen(),
      },
    );
  }
}
