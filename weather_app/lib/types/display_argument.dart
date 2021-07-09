import 'package:flutter/material.dart';
import 'package:weather_app/types/weather_data.dart';

class DisplayArgs {

  double scale;
  double orthoScale;
  String location;
  String description;
  Image iconImage;
  String temp;
  String feelsLike;
  String tempMax;
  String tempMin;
  List<WeatherData> hourly;

  DisplayArgs(this.scale, this.orthoScale, this.location, this.description,
      this.iconImage, this.temp, this.feelsLike, this.tempMax, this.tempMin,
      this.hourly);
}
