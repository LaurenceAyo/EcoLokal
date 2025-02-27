import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Import Welcome Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoLokal',
      theme: ThemeData(
        primarySwatch: Colors.green, // Define a theme
      ),
      home: WelcomeScreen(), // Set the first screen
    );
  }
}