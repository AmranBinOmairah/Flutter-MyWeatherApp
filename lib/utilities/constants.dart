import 'package:flutter/material.dart';

const kTempTextStyle =
    TextStyle(fontSize: 85.0, color: Colors.black, fontWeight: FontWeight.w700);

const kMessageTextStyle =
    TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w400);

const kButtonTextStyle =
    TextStyle(fontFamily: 'Spartan MB', fontSize: 25.0, color: Colors.black);

const kConditionTextStyle = TextStyle(fontSize: 100.0);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10.0))),
);

const kLocationBackgroundDecoration = BoxDecoration(
  gradient: RadialGradient(
    center: Alignment(0.0, -0.2),
    colors: [
      Color(0xFF86C6FE),
      Color(0xffD6D4D7),
    ],
  ),
);
