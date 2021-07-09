import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../types/weather_data.dart';
import 'api_key.dart';

class ApiManager {

  String lat = ''; // latitude of current position
  String lon = ''; // longitude of current position
  String apiUrl = ''; // the url of API to request the data from
  WeatherData currentData = WeatherData.empty(); // contins current weather info
  List<WeatherData> hourlyData = []; // list of weatherdata datatype to contain hourly forecasts

  ApiManager(lat, lon) { // uses lat, lon values retrieved from geolocator that makes API call relative to current position

      this.lat = lat;
      this.lon = lon;
      this.apiUrl = 'https://api.openweathermap.org/data/2.5/onecall?lat=${this.lat}&lon=${this.lon}&appid=${ApiKey.apiKey}&units=metric&lang=kr';
  }

  Future<void> fetch() async {

    try {
      // http get request, parse the response data and store them in jsonData
      Response response = await get(Uri.parse(this.apiUrl));
      Map jsonData = jsonDecode(utf8.decode(response.bodyBytes));

      // store the http response into each variable
      currentData = WeatherData(
        DateTime.fromMillisecondsSinceEpoch(jsonData['current']['dt'] * 1000),
        jsonData['current']['weather'][0]['icon'],
        double.parse(jsonData['current']['temp'].toString()),
        // city: something // add city info later on
        feelsLike: double.parse(jsonData['current']['feels_like'].toString()),
        lat: double.parse(jsonData['lat'].toString()),
        lon: double.parse(jsonData['lon'].toString()),
        description: jsonData['current']['weather'][0]['description'],
        tempMax: double.parse(jsonData['daily'][0]['temp']['max'].toString()),
        tempMin: double.parse(jsonData['daily'][0]['temp']['min'].toString()),
      );

      for (Map<String, dynamic> entity in jsonData['hourly']) {
        hourlyData.add(WeatherData(
          DateTime.fromMillisecondsSinceEpoch(entity['dt'] * 1000),
          entity['weather'][0]['icon'],
          double.parse(entity['temp'].toString()),
        ));
      }

      hourlyData.removeAt(0);
    }
    catch (error) {
      print('SYSALERT - ERROR: error during api response fetching process. Error: ${error}');
      currentData = WeatherData.empty();
    }
  }
}