// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_screen.dart';
import 'package:weather/weather.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';

class CityScreen extends StatefulWidget {
  final WeatherModel weatherData;
  const CityScreen({super.key, required this.weatherData});

  @override
  CityScreenState createState() => CityScreenState();
}

class CityScreenState extends State<CityScreen> {
  late int temp;
  late String cityName;
  late String icon;
  late String description;
  late Weather w;
  late List<double> tempList;
  late List<String> iconList;
  String errorText = '';
  WeatherFactory wf = WeatherFactory(kApiKey);
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> getCityWeatherData() async {
    // w = await wf.currentWeatherByCityName(cityName);
    // widget.weatherData.temp = w.temperature!.celsius!;
    // widget.weatherData.name = w.areaName!;
    // widget.weatherData.weatherId = w.weatherConditionCode!;
    await widget.weatherData.getCityLocationWeather(cityName);
    await widget.weatherData.getCitytLocationWeatherFiveDays(cityName);
    temp = widget.weatherData.temp.toInt();
    icon = widget.weatherData.getWeatherIcon();
    description = widget.weatherData.getMessage();
    cityName = widget.weatherData.name;
    tempList = widget.weatherData.tempList;
    iconList = widget.weatherData.iconList;
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return LocationScreen(
          weatherData: widget.weatherData,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backGround.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () async {
                      await widget.weatherData.getCurrentLocationWeather();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationScreen(
                                weatherData: widget.weatherData,
                              )));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a City ";
                        }
                        cityName = value;
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22))),
                          label: Text("Enter your city name")),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await getCityWeatherData();
                    } catch (e) {
                      setState(() {
                        errorText = "City not found\nspell correctly!";
                      });
                    }
                  }
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  errorText,
                  style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
