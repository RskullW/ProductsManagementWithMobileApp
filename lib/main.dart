import 'package:flutter/material.dart';
import 'package:nonton_test/add_screen.dart';
import 'package:nonton_test/display_screen.dart';
import 'package:nonton_test/find_screen.dart';
import 'package:nonton_test/home_screen.dart';
import 'package:nonton_test/products.dart';
import 'package:nonton_test/remove_screen.dart';

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
        child: HomeScreen(),
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
