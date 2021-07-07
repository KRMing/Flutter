import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';

class WorldTime {

  String? location; // location name for the UI
  String? time; // time in the location
  String? flag; // url to an asset flag icon
  String? url; // location url for api endpoint
  bool isDaytime = false; // true of false depending on daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try {

      // make the request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/${url!}'));
      Map data = jsonDecode(response.body);

      // get properties from the data
      String? datetime = data['datetime'];
      String? offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime!);
      now = now.add(Duration(hours: int.parse(offset!)));

      // set the time property
      isDaytime = 5 < now.hour && now.hour < 17 ? true: false;
      time = DateFormat.jm().format(now);
    }
    catch (error) {

      print('caught: error: ${error}');
      time = 'could not get time variable';
    }
  }
}