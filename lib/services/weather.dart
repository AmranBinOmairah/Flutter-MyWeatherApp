import 'package:flutter/material.dart';

import '../services/location.dart';
import '../services/networking.dart';

// Add your own API Key below
const apiKey = '';
const OPENWEATHERURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper('$OPENWEATHERURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$OPENWEATHERURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '⛈️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '☔';
    } else if (condition < 700) {
      return '⛄';
    } else if (condition < 800) {
      return '🌫️';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷🏽‍♂️';
    }
  }

  Color getBackgroundColor(int condition) {
    if (condition < 300) {
      return const Color(0xFF86C6FE);
    } else if (condition < 400) {
      return const Color(0xFF86C6FE);
    } else if (condition < 600) {
      return const Color(0xFFAED9FE);
    } else if (condition < 700) {
      return const Color(0xFFAED9FE);
    } else if (condition < 800) {
      return const Color(0xFFAED9FE);
    } else if (condition == 800) {
      return const Color(0xffD8C5B6);
    } else if (condition <= 804) {
      return const Color(0xFFAED9FE);
    } else {
      return const Color(0xffD8C5B6);
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
