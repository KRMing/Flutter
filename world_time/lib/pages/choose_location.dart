import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  int counter = 0;

  void getData() async {
    
    // simulate network request for a username
    await Future.delayed(Duration(seconds: 3), () { // same as async in swift
      print('yoshi');

    });

    await Future.delayed(Duration(seconds: 2), () {
      print('mario');
    });

    print('something');
  }
  
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar( // automatically sets a back arrow to the navigation bar, good for transitions
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ElevatedButton.icon(
        onPressed: () {
          setState(() {
            counter += 1;
          });
        },
        label: Text('counter is ${counter}'),
        icon: Icon(Icons.smart_button),
      ),


    );
  }
}
