import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  Widget toListViewTemplate() {

    String prefix = (12 <= this.dt.hour && this.dt.hour < 24) ? '오후' : '오전';
    int hour = (12 < this.dt.hour && this.dt.hour <= 24) ? this.dt.hour - 12 : (this.dt.hour == 0) ? this.dt.hour + 12 : this.dt.hour;
    String hourDisplay = '${prefix} ${hour.toString()}시';

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              hourDisplay,
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.blue[200],
            radius: 25,
            child: Image.network(
              this.iconUrl,
              scale: 1.0,
            ),
          ),
          SizedBox(height: 1),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 3),
                Text(
                  '${this.temp.floor().toString()}\u00b0',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 18,
                    color: Colors.white
                  )
                ),
              ]
            )
          ),
        ],
      ),
    );
  }

  void printAll() {

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