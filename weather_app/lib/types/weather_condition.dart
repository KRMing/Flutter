import 'package:flutter/material.dart';

class Cond {

  int id = 0;
  String main = '';
  String description = '';
  String iconCode = '';
  String iconUrl = '';

  Cond(id, main, description, iconCode) {

    this.id = id;
    this.main = main;
    this.description = description;
    this.iconCode = iconCode;
    this.iconUrl = 'http://openweathermap.org/img/wn/${this.iconCode}@2x.png';
  }
}