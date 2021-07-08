import 'package:flutter/material.dart';

class WeatherData {

  DateTime dt;
  String iconId;
  double temp;

  double feelsLike;
  String city;
  double lat;
  double lon;
  String description;
  double tempMax;
  double tempMin;

  bool isEmpty;
  String iconUrl;

  WeatherData(this.dt, this.iconId, this.temp, {this.feelsLike = 0.0, this.city = '', this.lat = 0.0, this.lon = 0.0, this.description = '', this.tempMax = 0.0, this.tempMin = 0.0, this.isEmpty = false, this.iconUrl = '', }) {

    this.iconUrl = 'http://openweathermap.org/img/wn/${this.iconId}@2x.png';
  }

  WeatherData.empty() : this(DateTime.now(), '', 0.0, isEmpty: true);

  void print_all() {

    print('\n\n printing all fields: ');
    print(this.dt);
    print(this.iconId);
    print(this.temp);
    print(this.feelsLike);
    print(this.city);
    print(this.lat);
    print(this.lon);
    print(this.description);
    print(this.tempMax);
    print(this.tempMin);
    print(this.isEmpty);
    print(iconUrl);
    print('\n\n');
  }
}