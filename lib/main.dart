import 'package:flutter/material.dart';
import 'package:myweatherapp/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Weather App',
      theme: ThemeData.dark(),
      home: const LoadingScreen(),
    );
  }
}
