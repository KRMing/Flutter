import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../types/weather_condition.dart';
import '../types/weather_temperature.dart';
import 'api_key.dart';

class ApiManager {

  String apiUrl = '';
  Cond? condition; // datatype for containing weather condition related data
  Temp? temperature; // datatype for containing temperature related data
  String? location;

  ApiManager({city, state, country, id}) { // either use (city, state, country) or (id) parameters for initialization
    try {
      this.apiUrl = id.isEmpty
          ? 'https://api.openweathermap.org/data/2.5/weather?q=${city},${state},${country}&appid=${ApiKey.apiKey}&lang=kr&units=metric'
          : 'http://api.openweathermap.org/data/2.5/weather?id=${id}&appid=${ApiKey.apiKey}&lang=kr&units=metric';
    }
    catch (error) {
      apiUrl = 'invalid initialization';
      print('SYSALERT - ERROR: invalid initailization while creating apimanager instance. Error: ${error}');
    }
  }

  Future<void> fetch() async {
    try {
      // http get request, parse json data and store them in responseData
      Response response = await get(Uri.parse(this.apiUrl));
      Map responseData = jsonDecode(utf8.decode(response.bodyBytes));

      print(responseData);

      // store the http response
      Map weather = responseData['weather'][0];
      Map main = responseData['main'];

      this.condition = Cond(weather['id'], weather['main'], weather['description'], weather['icon']);
      this.temperature = Temp(main['temp'].floor(), main['feels_like'].floor(), main['temp_min'].floor(),
          main['temp_max'].floor(), main['pressure'], main['humidity']);
      this.location = responseData['name'];
    }
    catch (error) {
      print('SYSALERT - ERROR: error during fetching process. Error: ${error}');
      this.condition = null;
      this.temperature = null;
    }


  }
}