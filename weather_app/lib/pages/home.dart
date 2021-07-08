import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map weatherData = {};

  @override
  Widget build(BuildContext context) {

    weatherData = weatherData.isNotEmpty ? weatherData : ModalRoute.of(context)?.settings.arguments as Map;

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
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Text(
                        '${weatherData['temp']}\u00b0',
                        style: TextStyle(
                          fontFamily: 'Jua',
                          fontSize: 90,
                          color: Colors.white,
                        )),
                  ]
                )
              ),
              Center(
                child: Text(
                    '체감 온도: ${weatherData['feelsLike']}\u00b0',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 30,
                      color: Colors.grey[200],
                    )),
              ),
              Center(
                child: Text(
                    '최고 ${weatherData['tempMax']}\u00b0 / 최저 ${weatherData['tempMin']}\u00b0',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 20,
                      color: Colors.grey[300],
                    )),
              ),
              SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
    );
  }
}