import 'package:flutter/material.dart';
import '../api/api_manager.dart';

void main() {
  runApp(
    MaterialApp(
      home: WeatherApp(),
    )
  );
}

class WeatherApp extends StatefulWidget {


  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ApiManager getapi = ApiManager(id: '1835847');
    getapi.fetch();
  }

  @override
  Widget build(BuildContext context) {
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
                  '{현재 위치}',
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
              Center(
                child: Text(
                    '{날씨 요약}',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 20,
                      color: Colors.white
                    )),
              ),
              SizedBox(height: 15),
              Icon(
                Icons.wb_sunny_outlined,
                size: 175.0,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                    '{기온}',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 50,
                      color: Colors.white,
                    )),
              ),
              Center(
                child: Text(
                    '{비교 문구}',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 30,
                      color: Colors.white,
                    )),
              ),
              Center(
                child: Text(
                    '{최고 기온} / {최저 기온}',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: 20,
                      color: Colors.white,
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

