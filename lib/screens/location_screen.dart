import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/services/weather.dart';

import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatherData;

  const LocationScreen({super.key, required this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temp;
  late String cityName;
  late String icon;
  late String description;
  late String image;
  late List<double> tempList;
  late List<String> iconList;
  late List date;
  int index = 0;
  // WeatherModel weatherInfo = WeatherModel();

  void updateUi() {
    temp = widget.weatherData.temp.toInt();
    cityName = widget.weatherData.name;
    icon = widget.weatherData.getWeatherIcon();
    description = widget.weatherData.getMessage();
    image = widget.weatherData.getImage();
    tempList = widget.weatherData.tempList;
    iconList = widget.weatherData.iconList;
    date = widget.weatherData.date;
  }

  @override
  void initState() {
    updateUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: AssetImage('images/location_background.jpg'),
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(1), BlendMode.dstATop),
                ),
              ),
              constraints: const BoxConstraints.expand(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.3)
                      // color: Colors.white.withOpacity(0.0),
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          await widget.weatherData.getCurrentLocationWeather();
                          await widget.weatherData
                              .getCurrentLocationWeatherFiveDays();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                    weatherData: widget.weatherData,
                                  )));
                        },
                        child: const Icon(
                          Icons.near_me,
                          size: 34.0,
                          color: kSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CityScreen(
                                    weatherData: widget.weatherData,
                                  )));
                        },
                        child: const Icon(
                          Icons.location_city,
                          size: 34 - .0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        icon,
                        style: const TextStyle(fontSize: 52),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$temp',
                            style: kTempTextStyle,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 10),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 7,
                                width: 35,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                    // shape: BoxShape.circle,
                                    ),
                              ),
                              const Text(
                                'now',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Spartan MB',
                                  letterSpacing: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    description,
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                  Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.1)),
                    padding: const EdgeInsets.all(12),
                    height: 150,
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${iconList[index]}",
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                  Text(
                                    "${tempList[index].floor()}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "${date[index]}",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  ClipRRect(
                    child: Container(
                      padding: const EdgeInsets.all(34),
                      child: Center(
                        child: Text(
                          cityName,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
