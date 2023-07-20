import 'package:flutter/material.dart';
import 'package:weather_app/services/location.dart';
import '../utilities/constants.dart';
import 'networking.dart';
import 'package:date_format/date_format.dart' as DateFormat;

class WeatherModel {
  double temp = 0;
  int weatherId = 0;
  String name = '';
  List<double> tempList = [];
  List<int> weatherIdList = [];
  List<String> iconList = [];
  List date = [];
  late String image;
  late List weatherData;

  Future<void> getCityLocationWeather(String cityName) async {
    // WeatherFactory wf = WeatherFactory(kApiKey);
    // Weather w = await wf.currentWeatherByCityName(cityName);
    // temp = w.temperature as double;
    Map<String, dynamic> weatherInfo = await NetworkHelper(
            url:
                "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$kApiKey&units=metric")
        .getData();
    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    cityName = weatherInfo['name'];
    name = cityName;
  }

  Future<void> getCurrentLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url: 'https://api.openweathermap.org/data/2.5/weather?'
          'lat=${location.lat}&lon=${location.long}'
          '&appid=$kApiKey&units=metric',
    ).getData();
    temp = weatherInfo['main']['temp'];
    weatherId = weatherInfo['weather'][0]['id'];
    name = weatherInfo['name'];
  }

  Future<void> getCurrentLocationWeatherFiveDays() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url:
          'https://api.openweathermap.org/data/2.5/forecast?lat=${location.lat}&lon=${location.long}&appid=$kApiKey&units=metric',
    ).getData();
// [0]['main']['temp']
    tempList = [];
    weatherIdList = [];
    for (var i = 0; i < 5; i++) {
      tempList.add(weatherInfo['list'][i]['main']['temp']);
      weatherIdList.add(weatherInfo['list'][i]['weather'][0]['id']);
      date.add(DateFormat.formatDate(
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + i),
          ['DD']));
      if (weatherIdList[i] < 300) {
        iconList.add('🌩');
      } else if (weatherIdList[i] < 400) {
        iconList.add('🌧');
      } else if (weatherIdList[i] < 600) {
        iconList.add('☔️');
      } else if (weatherIdList[i] < 700) {
        iconList.add('☃️');
      } else if (weatherIdList[i] < 800) {
        iconList.add('🌫');
      } else if (weatherIdList[i] == 800) {
        iconList.add('☀️');
      } else if (weatherIdList[i] <= 804) {
        iconList.add('☁️');
      } else {
        iconList.add('🤷‍');
      }
    }
    // temp = weatherInfo['list'][index]['main']['temp'];
    // name = weatherInfo['list']['city']['name'];
  }

  Future<void> getCitytLocationWeatherFiveDays(String cityName) async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, dynamic> weatherInfo = await NetworkHelper(
      url:
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$kApiKey&units=metric',
    ).getData();
// [0]['main']['temp']
    tempList = [];
    weatherIdList = [];
    for (var i = 0; i < 5; i++) {
      tempList.add(weatherInfo['list'][i]['main']['temp']);
      date.add(DateFormat.formatDate(DateTime(DateTime.now().day + i), ['DD']));
      weatherIdList.add(weatherInfo['list'][i]['weather'][0]['id']);
      if (weatherIdList[i] < 300) {
        iconList.add('🌩');
      } else if (weatherIdList[i] < 400) {
        iconList.add('🌧');
      } else if (weatherIdList[i] < 600) {
        iconList.add('☔️');
      } else if (weatherIdList[i] < 700) {
        iconList.add('☃️');
      } else if (weatherIdList[i] < 800) {
        iconList.add('🌫');
      } else if (weatherIdList[i] == 800) {
        iconList.add('☀️');
      } else if (weatherIdList[i] <= 804) {
        iconList.add('☁️');
      } else {
        iconList.add('🤷‍');
      }
    }
    print(tempList[0]);
    // temp = weatherInfo['list'][index]['main']['temp'];
    // name = weatherInfo['list']['city']['name'];
  }

  String getWeatherIcon() {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
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

  String getImage() {
    if (weatherId < 300) {
      return 'images/cold.jpeg';
    } else if (weatherId < 400) {
      return 'images/cold.jpeg';
    } else if (weatherId < 600) {
      return 'images/cold.jpeg';
    } else if (weatherId < 700) {
      return 'images/winter.jpeg';
    } else if (weatherId < 800) {
      return 'images/winter.jpeg';
    } else if (weatherId == 800) {
      return 'images/summer.jpeg';
    } else if (weatherId <= 804) {
      return 'images/spring.jpeg';
    } else {
      return '🤷‍';
    }
  }
}
