import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// Step 1: Project Setup
void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Detail App',
      home: HomeScreen(),
    );
  }
}
