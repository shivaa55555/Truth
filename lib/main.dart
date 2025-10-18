// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/splashscreen.dart'; // ← screens folder मधून import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruthSpice',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const SplashScreen(), // ← SplashScreen वरून start
      debugShowCheckedModeBanner: false,
    );
  }
}
