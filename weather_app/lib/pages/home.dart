import 'package:flutter/material.dart';
import 'package:weather_app/types/weather_data.dart';
import 'dart:async';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static const int updateInterval = 5;
  Map weatherData = {};

  void toLoadingPage() {
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {

    Timer timer = Timer(Duration(minutes: updateInterval), toLoadingPage);

    weatherData = weatherData.isNotEmpty ? weatherData : ModalRoute.of(context)?.settings.arguments as Map;

    int bgIntensity = 0;
    int currentHour = DateTime.now().hour;
    if (6 <= currentHour && currentHour <= 9) {
      bgIntensity = 700;
    }
    else if (9 < currentHour && currentHour <= 18) {
      bgIntensity = 600;
    }
    else if (18 < currentHour && currentHour <= 20) {
      bgIntensity = 700;
    }
    else if (20 < currentHour && currentHour <= 22) {
      bgIntensity = 800;
    }
    else {
      bgIntensity = 900;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 50,
        backgroundColor: Colors.blue[600],
        centerTitle: true,
        title:
        Container(
          margin: EdgeInsets.only(top:15.0),
          child: Text(
              weatherData['location'],
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 35,
              )),
        ),
      ),

      body: Center(
        child: Container(
          // width: double.infinity,
          color: Colors.blue[600],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5),
              Center(
                child: Text(
                    weatherData['description'],
                    style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 20,
                        color: Colors.grey[200],
                    )),
              ),
              Container(
                width: double.infinity,
                height: 150.0,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                color: Colors.blue[600],
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: weatherData['iconImage'],
                    radius: 50,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 110,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 40),
                      Text(
                          '${weatherData['temp']}\u00b0',
                          style: TextStyle(
                            fontFamily: 'Jua',
                            fontSize: 100,
                            color: Colors.white
                          )),
                    ]
                  )
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                      '체감 온도: ${weatherData['feelsLike']}\u00b0',
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 30,
                        color: Colors.grey[200],
                      )),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                      '최고 ${weatherData['tempMax']}\u00b0 / 최저 ${weatherData['tempMin']}\u00b0',
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 20,
                        color: Colors.grey[300],
                      )),
                ),
              ),
              SizedBox(height: 30),
              Container(
                color: Colors.blue[800],
                child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        margin: EdgeInsets.only(right: 160),
                        child: Text(
                            '오늘',
                            style: TextStyle(
                              fontFamily: 'Jua',
                              fontSize: 20,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 15.0),
                        margin: EdgeInsets.only(left: 165),
                        child: Icon(
                          Icons.insert_chart,
                          color: Colors.white,
                        )
                      ),
                    ]
                ),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherData['hourly'].length,
                  itemBuilder: (context, index) {
                    return weatherData['hourly'][index].toListViewTemplate(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}