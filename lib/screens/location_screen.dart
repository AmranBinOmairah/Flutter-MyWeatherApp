import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myweatherapp/screens/city_screen.dart';
import 'package:myweatherapp/services/weather.dart';
import 'package:myweatherapp/utilities/constants.dart';
import 'package:myweatherapp/services/weather.dart';
import '../services/reusable_card.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temperature;
  // int? condition;
  String? weatherIcon;
  String? cityName;
  String? weatherMessage;
  int? humidity;
  String? description;
  Color? backgroundColor;
  int? wind;
  int? visibility;
  int? lTemp;
  int? hTemp;
  int? feels;
  DateTime? timezone;
  DateFormat? dateFormat;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherMessage = 'Unable to get weather data';
        weatherIcon = '❗';
        cityName = 'No City Found';
        humidity = 0;
        description = '';
        backgroundColor = const Color(0xffD8C5B6);
        wind = 0;
        visibility = 0;
        lTemp = 0;
        hTemp = 0;
        feels = 0;
        timezone = "No Timezone" as DateTime?;
        return;
      }

      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var tempLow = weatherData['main']['temp_min'];
      lTemp = tempLow.toInt();
      var tempHigh = weatherData['main']['temp_max'];
      hTemp = tempHigh.toInt();
      var tempFeels = weatherData['main']['feels_like'];
      feels = tempFeels.toInt();
      weatherMessage = weather.getMessage(temperature!);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      backgroundColor = weather.getBackgroundColor(condition);
      cityName = weatherData['name'];
      humidity = weatherData['main']['humidity'];
      String tempDescription = weatherData['weather'][0]['description'];
      description =
          tempDescription.split(' ').map((word) => word.capitalize()).join(' ');
      var tempWind = weatherData['wind']['speed'];
      wind = tempWind.toInt();
      // var tempPressure = weatherData['main']['pressure'];
      // pressure = tempPressure.toInt();
      var tempVisibility = weatherData['visibility'] / 1000;
      visibility = tempVisibility.toInt();
      var tempTimezone = weatherData['timezone'];
      timezone = DateTime.now().add(Duration(
          seconds: tempTimezone! - DateTime.now().timeZoneOffset.inSeconds));
      print(timezone);

      dateFormat = DateFormat("EEEE, d MMM h:mm a");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.0, -0.2),
            colors: [
              backgroundColor!,
              // Color(0xffD8C5B6),
              const Color(0xffD6D4D7),
            ],
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: const Icon(
                        Icons.near_me,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var typedName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CityScreen();
                        }));
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: const Icon(
                        Icons.location_city,
                        size: 50.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Text(
                      cityName!,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${dateFormat?.format(timezone!)}',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      weatherIcon!,
                      style: kConditionTextStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                    ),
                    Text(
                      description!,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      'H:$hTemp° L:$lTemp°',
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Center(
                      child: Text(
                        // "$weatherMessage in $cityName!",
                        "$weatherMessage!",
                        textAlign: TextAlign.center,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCard(
                          featureIcon: Icons.air_outlined,
                          featureText: 'Wind',
                          featureValue: '$wind' 'km/h',
                        ),
                        const VerticalDivider(
                          width: 5.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Colors.grey,
                        ),
                        ReusableCard(
                          featureIcon: Icons.wb_sunny_outlined,
                          featureText: 'Feels like',
                          featureValue: '$feels°',
                        ),
                        const VerticalDivider(
                          width: 5.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Colors.grey,
                        ),
                        ReusableCard(
                          featureIcon: Icons.visibility_outlined,
                          featureText: 'Visibility',
                          featureValue: '$visibility' 'km',
                        ),
                        const VerticalDivider(
                          width: 5.0,
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Colors.grey,
                        ),
                        ReusableCard(
                          featureIcon: Icons.water_drop_outlined,
                          featureText: 'Humidity',
                          featureValue: '$humidity%',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
