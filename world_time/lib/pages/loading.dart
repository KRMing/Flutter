import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String time = 'loading';
  List<String> bgImagePaths = ['images/day.png', 'images/night.png'];
  List<Image> bgImages = [];

  void setupWorldTime() async {

    WorldTime instance = WorldTime(location: 'Seoul', flag: 'korea.png', url: 'Asia/Seoul');
    await instance.getTime();
    await Future.delayed(Duration(seconds: 1)); // delayed to check loading circle
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      // should do error handling for null values here
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();

    for (var path in bgImagePaths) {
      bgImages.add(Image.asset(path));
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    bgImages.map((image) => precacheImage(image.image, context));
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.grey[600],
          size: 50.0,
          duration: Duration(milliseconds: 500),
        )
      ),
    );
  }
}
