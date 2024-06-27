import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  const ReusableCard(
      {super.key,
      required this.featureIcon,
      required this.featureText,
      required this.featureValue});

  final IconData featureIcon;
  final String featureText;
  final String featureValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          featureIcon,
          color: Colors.black,
        ),
        Text(
          featureValue,
          style: const TextStyle(
              fontSize: 17.0, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        Text(
          featureText,
          style: const TextStyle(fontSize: 15.0, color: Colors.grey),
        ),
      ],
    );
  }
}
