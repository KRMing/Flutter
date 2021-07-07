import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'api_key.dart';

class ApiManager {

  String apiUrl = '';

  ApiManager({city, state, country, id}) { // either use (city, state, country) or (id) parameters for initialization
    try {
      this.apiUrl = id.isEmpty
          ? 'https://api.openweathermap.org/data/2.5/weather?q=${city},${state},${country}&appid=${ApiKey
          .apiKey}'
          : 'https://api.openweathermap.org/data/2.5/weather?id=${id}&appid=${ApiKey
          .apiKey}';
    }
    catch (error) {
      apiUrl = 'invalid initialization';
      print('SYSALERT: invalid initailization while creating apimanager instance.');
    }
  }

  Future<void> fetch() async {
    // http get request, parse json data and store them in responseData
    try {
      Response response = await get(Uri.parse(this.apiUrl));
      Map responseData = jsonDecode(response.body);
      print(responseData);
    }
    catch (error) {
      print('SYSALERT: failed to fetch response from api url.');
    }

    //

  }
}