import 'package:flutter/material.dart';
import 'package:weather_app/types/weather_data.dart';
import 'package:weather_app/types/display_argument.dart';
import 'dart:async';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final int updateInterval = 5;

  void toLoadingPage() {

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    DisplayArgs displayArgs = ModalRoute.of(context)?.settings.arguments as DisplayArgs;

    double scale = displayArgs.scale;
    double orthoScale = displayArgs.orthoScale;

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

    Timer timer = Timer(Duration(minutes: this.updateInterval), this.toLoadingPage);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 50 * orthoScale,
        backgroundColor: Colors.blue[bgIntensity],
        centerTitle: true,
        title:
        Container(
          margin: EdgeInsets.only(top:15.0 * orthoScale),
          child: Text(
              displayArgs.location,
              style: TextStyle(
                fontFamily: 'Jua',
                fontSize: 35 * orthoScale,
              )),
        ),
      ),
      body: Center(
        child: Container(
          // width: double.infinity,
          color: Colors.blue[bgIntensity],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 5 * orthoScale),
              Center(
                child: Text(
                    displayArgs.description,
                    style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 20 * orthoScale,
                        color: Colors.grey[200],
                    )),
              ),
              Container(
                width: double.infinity,
                height: 150.0 * orthoScale,
                padding: EdgeInsets.symmetric(vertical: 5 * orthoScale, horizontal: 0 * orthoScale),
                color: Colors.blue[bgIntensity],
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: displayArgs.iconImage,
                    radius: 50 * orthoScale,
                ),
              ),
              SizedBox(height: 10 * orthoScale),
              Container(
                height: 110 * orthoScale,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 40 * orthoScale),
                      Text(
                          '${displayArgs.temp}\u00b0',
                          style: TextStyle(
                            fontFamily: 'Jua',
                            fontSize: 100 * orthoScale,
                            color: Colors.white
                          )),
                    ]
                  )
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                      '체감 온도: ${displayArgs.feelsLike}\u00b0',
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 30 * orthoScale,
                        color: Colors.grey[200],
                      )),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                      '최고 ${displayArgs.tempMax}\u00b0 / 최저 ${displayArgs.tempMin}\u00b0',
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 20 * orthoScale,
                        color: Colors.grey[200],
                      )),
                ),
              ),
              SizedBox(height: 30 * orthoScale * orthoScale),
              Container(
                color: (bgIntensity + 200 > 900) ? Colors.black : Colors.blue[bgIntensity + 200],
                child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 15.0),
                        margin: EdgeInsets.only(right: 160),
                        child: Text(
                            '오늘',
                            style: TextStyle(
                              fontFamily: 'Jua',
                              fontSize: 20 * orthoScale,
                              color: Colors.white,
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 15.0 * scale),
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
                flex: 10,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: displayArgs.hourly.length,
                  itemBuilder: (context, index) {
                    return displayArgs.hourly[index].toListViewTemplate(index, scale, orthoScale);
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(height: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}