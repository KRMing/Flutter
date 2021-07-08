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
    try {
      this.lat = lat;
      this.lon = lon;
      this.apiUrl = 'https://api.openweathermap.org/data/2.5/onecall?lat=${this.lat}&lon=${this.lon}&appid=${ApiKey.apiKey}&units=metric&lang=kr';
    }
    catch (error) {
      print('SYSALERT - ERROR: invalid initailization while creating api urls, possibly the forecast url. Error: ${error}');
    }
  }

  double checkDouble(dynamic obj) {

    if (!(obj is double)) {
      obj = obj.toDouble();
    }

    return obj;
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
        checkDouble(jsonData['current']['temp']),
        // city: something // add city info later on
        feelsLike: checkDouble(jsonData['current']['feels_like']),
        lat: checkDouble(jsonData['lat']),
        lon: checkDouble(jsonData['lon']),
        description: jsonData['current']['weather'][0]['description'],
        tempMax: checkDouble(jsonData['daily'][0]['temp']['max']),
        tempMin: checkDouble(jsonData['daily'][0]['temp']['min']),
      );

      for (Map<String, dynamic> entity in jsonData['hourly']) {
        hourlyData.add(WeatherData(
          DateTime.fromMillisecondsSinceEpoch(entity['dt'] * 1000),
          entity['weather'][0]['icon'],
          entity['temp'],
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