import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pausable_timer/pausable_timer.dart';
import 'package:weather_app/models/mappings.dart';
import 'dart:math';

class WeatherData {

  DateTime dt;
  String iconId;
  double temp;

  Image? image;
  Image? altImage;
  double feelsLike;
  String city;
  double lat;
  double lon;
  String description;
  double tempMax;
  double tempMin;
  double pop;
  double? rain;
  double uvi;
  double windSpeed;
  double humidity;
  double visibility;

  bool isEmpty;
  String iconUrl;

  WeatherData(this.dt, this.iconId, this.temp,
      { this.image, this.altImage, this.feelsLike = 0.0, this.city = '', this.lat = 0.0,
        this.lon = 0.0, this.description = '', this.tempMax = 0.0,
        this.tempMin = 0.0, this.pop = 0.0, this.rain = 0.0, this.uvi = 0.0, this.windSpeed = 0.0,
      this.humidity = 0.0, this.visibility = 0.0, this.isEmpty = false, this.iconUrl = '', }) {

    this.iconUrl = 'http://openweathermap.org/img/wn/${this.iconId}@2x.png';
  }

  WeatherData.empty() : this(DateTime.now(), '', 0.0, isEmpty: true);

  void displayDialog(BuildContext context, PausableTimer? timer, int index, String hourDisplay, double scale, double orthoScale) {

    timer?.pause();

    this.dt.add(Duration(days: index ~/ 24));
    String dayInWeek = DateFormat('EEEE').format(this.dt);
    String dateDisplay = '${this.dt.month.toString()}.${this.dt.day.toString()} (${Mappings.days[dayInWeek]})';

    double rain = (this.rain == null) ? 0.0 : this.rain!;
    String doesRain = (this.rain == null) ? '없음' : '';
    String uvText = (this.uvi >= 6) ? '높음' : (this.uvi >= 4) ? '중간' : '낮음';
    String windText = (this.windSpeed > 6) ? '강함' : (this.windSpeed > 3) ? '보통' : '약함';
    int humidity = this.humidity.toInt();
    String humidityText = (humidity > 65) ? '높음' : (humidity > 35) ? '중간' : '낮음';
    int visibility = (this.visibility / 1000).toInt();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.fromLTRB(25 * orthoScale, 70 * orthoScale, 25 * orthoScale, 50 * orthoScale),
        elevation: 0,
        child: Center(
          child: Container(
            constraints: BoxConstraints.expand(),
            margin: EdgeInsets.symmetric(horizontal: 10 * orthoScale),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15 * orthoScale),
              color: Colors.grey[900],
            ),
            child: Column( // MAIN COLUMN
              children: [
                Expanded( // DATE, BUTTON BAR
                  flex: 2,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            color:Colors.transparent,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            height: double.infinity,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                dateDisplay,
                                style: TextStyle(
                                  fontFamily: 'Jua',
                                  fontSize: 15 * orthoScale,
                                  color: Colors.white,
                                )
                              )
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.close,
                                size: 30 * orthoScale,
                                color: Colors.white,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.transparent),
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded( // HOUR and TIME
                  flex: 1,
                  child: Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        hourDisplay,
                        style: TextStyle(
                          fontFamily: 'Jua',
                          fontSize: 25 * orthoScale,
                          color: Colors.white,
                        )
                      ),
                    )
                  ),
                ),
                Expanded( // SUMMARY AND RAIN POP
                  flex:4,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15 * orthoScale, horizontal: 0),
                    child: Container(
                      color: Colors.blueGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 15 * orthoScale),
                            child: Row(
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: (this.image == null) ? this.altImage! : this.image!,
                                  )
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(1, 0, 0, 0),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              this.description,
                                              style: TextStyle(
                                                fontFamily: 'Jua',
                                                fontSize: (25 * orthoScale),
                                                color: Colors.white,
                                              )
                                            ),
                                          )
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              '비 올 확률: ${(this.pop * 100).floor().toString()}%',
                                              style: TextStyle(
                                                fontFamily: 'Jua',
                                                fontSize: 15 * orthoScale,
                                                color: Colors.blue[50],
                                              )
                                            ),
                                          )
                                        ),
                                      )
                                    ]
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded( // START OF 2 ELEMENTS
                  flex: 3,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Icon(
                                      Icons.device_thermostat,
                                      color: Colors.white,
                                      size: 50 * orthoScale,
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    '  온도: ${this.temp.floor().toString()}\u00b0\n  체감: ${this.feelsLike.floor().toString()}\u00b0',
                                    style: TextStyle(
                                      fontFamily: 'Jua',
                                      height: 0.95 * orthoScale,
                                      fontSize: 15 * orthoScale,
                                      color: Colors.blue[50],
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Icon(
                                    (this.rain == null) ? Icons.wb_sunny : Icons.umbrella,
                                    color: Colors.white,
                                    size: 50 * orthoScale,
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    '  강수: ${rain.toStringAsFixed(1)}mm\n       ${doesRain}',
                                    style: TextStyle(
                                      fontFamily: 'Jua',
                                      height: 0.95 * orthoScale,
                                      fontSize: 15 * orthoScale,
                                      color: Colors.blue[50],
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                ),
                Expanded( // START OF 2 ELEMENTS
                  flex: 3,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.white,
                                    size: 50 * orthoScale,
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    '자외선 수치: ${this.uvi.floor().toString()}\n        ${uvText}',
                                    style: TextStyle(
                                      fontFamily: 'Jua',
                                      height: 0.95 * orthoScale,
                                      fontSize: 15 * orthoScale,
                                      color: Colors.blue[50],
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Icon(
                                    Icons.stacked_line_chart,
                                    color: Colors.white,
                                    size: 50 * orthoScale,
                                  ),
                                )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    '  바람: ${this.windSpeed.toStringAsFixed(1)}km/h\n         ${windText}',
                                    style: TextStyle(
                                      fontFamily: 'Jua',
                                      height: 0.95 * orthoScale,
                                      fontSize: 15 * orthoScale,
                                      color: Colors.blue[50],
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                ),
                Expanded( // START OF 2 ELEMENTS
                  flex: 3,
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      child: Icon(
                                        Icons.water_rounded,
                                        color: Colors.white,
                                        size: 50 * orthoScale,
                                      ),
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                      child: Text(
                                          '  습도: ${humidity.toString()}%\n      ${humidityText}',
                                          style: TextStyle(
                                            fontFamily: 'Jua',
                                            height: 0.95 * orthoScale,
                                            fontSize: 15 * orthoScale,
                                            color: Colors.blue[50],
                                          )
                                      ),
                                    )
                                ),
                              ],
                            )
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.white,
                                      size: 50 * orthoScale,
                                    ),
                                  )
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Text(
                                    '가시거리: ${visibility}km\n',
                                    style: TextStyle(
                                      fontFamily: 'Jua',
                                      height: 0.95 * orthoScale,
                                      fontSize: 15 * orthoScale,
                                      color: Colors.blue[50],
                                    )
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
      )
    ).whenComplete(() => timer?.start());
  }

  Widget toListViewTemplate(BuildContext context, PausableTimer? timer, int index, double scale, double orthoScale) {

    String prefix = (12 <= this.dt.hour && this.dt.hour < 24) ? '오후' : '오전';
    int hour = (12 < this.dt.hour && this.dt.hour <= 24) ? this.dt.hour - 12 : (this.dt.hour == 0) ? this.dt.hour + 12 : this.dt.hour;
    String hourDisplay = '${prefix} ${hour.toString()}시';
    int textIndex = index ~/ 24;
    List<Widget> indicatorTexts = [
      Text(
        'Tomorrow',
        style: TextStyle(
          fontFamily: 'Jua',
          fontSize: 15 * orthoScale,
          color: Colors.white,
        ),
      ),
      Text(
        'The Day After\n    Tomorrow',
        style: TextStyle(
          fontFamily: 'Jua',
          fontSize: 15 * orthoScale,
          color: Colors.white,
        ),
      ),
    ];
    this.image = Image.network(
      this.iconUrl,
      scale: 1.0,
    );

    Widget weatherCard = Container(
      width: 83 * orthoScale,
      margin: EdgeInsets.symmetric(vertical: 15 * orthoScale, horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              hourDisplay,
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 15 * orthoScale,
                color: Colors.white,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              this.displayDialog(context, timer, index, hourDisplay, scale, orthoScale);
            },
            style: OutlinedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Colors.blue[200],
            ),
            child: Container(
              height: 65 * orthoScale,
              width: 65 * orthoScale,
              child: (this.image == null) ? this.altImage! : this.image!,
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 3 * orthoScale),
                Text(
                  '${this.temp.floor().toString()}\u00b0',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 18 * orthoScale,
                    color: Colors.white
                  )
                ),
              ]
            )
          ),
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
          margin: EdgeInsets.symmetric(vertical: 15 * orthoScale, horizontal: 5 * orthoScale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5 * orthoScale),
                height: (textIndex < 1) ? 50 * orthoScale : 60 * orthoScale,
                width: (textIndex < 1) ? 80 * orthoScale : 100 * orthoScale,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1 * orthoScale, color: Colors.white),
                    bottom: BorderSide(width: 1 * orthoScale, color: Colors.white)
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
}