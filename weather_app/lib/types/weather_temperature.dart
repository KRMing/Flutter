import 'dart:ffi';

import 'package:flutter/material.dart';

class Temp {

  int temp = 0;
  int feelsLike = 0;
  int tempMin = 0;
  int tempMax = 0;
  int pressure = 0;
  int humidity = 0;

  Temp(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure, this.humidity);
}