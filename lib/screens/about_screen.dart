import 'package:flutter/material.dart';
import 'package:myweatherapp/utilities/constants.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF86C6FE),
              Color(0xffD6D4D7),
              Color(0xffD8C5B6)
            ])),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios,
                      size: 50.0, color: Colors.black),
                ),
              ),
              const Center(
                child: Text(
                  'My Weather App',
                  style: kMessageTextStyle,
                ),
              ),
              const Text(
                'Amran Bin Omairah',
                style: TextStyle(color: Colors.black),
              ),
              const Text(
                '© 2024',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
