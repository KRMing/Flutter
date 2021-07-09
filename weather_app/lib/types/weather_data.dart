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

  Widget toListViewTemplate(int index) {

    List<Widget> indicatorTexts = [
      Text(
        'Tomorrow',
        style: TextStyle(
          fontFamily: 'Jua',
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      Text(
        'The Day After\n    Tomorrow',
        style: TextStyle(
          fontFamily: 'Jua',
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ];

    String prefix = (12 <= this.dt.hour && this.dt.hour < 24) ? '오후' : '오전';
    int hour = (12 < this.dt.hour && this.dt.hour <= 24) ? this.dt.hour - 12 : (this.dt.hour == 0) ? this.dt.hour + 12 : this.dt.hour;
    String hourDisplay = '${prefix} ${hour.toString()}시';
    int textIndex = index ~/ 24;

    Widget weatherCard = Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
            radius: 30,
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
          // SizedBox(height: 1),
        ],
      ),
    );

    if (!(this.dt.hour == 1 && prefix == '오전')) {
      return weatherCard;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                height: (textIndex < 1) ? 50 : 60,
                width: (textIndex < 1) ? 80 : 100,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1.0, color: Colors.white),
                      bottom: BorderSide(width: 1.0, color: Colors.white)
                  ),
                ),
                child: Center(
                  child: indicatorTexts[textIndex],
                ),
              ),
            ],
          ),
        ),
        weatherCard,
      ],
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