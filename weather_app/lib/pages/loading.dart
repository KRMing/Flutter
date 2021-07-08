import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/geolocator.dart';
import '../utils/api_manager.dart';
import '../types/mappings.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void prepareLoadData() async {

    GeoLocator location = GeoLocator();
    await location.getPosition();

    ApiManager apiData = ApiManager(location.lat, location.lon);
    await apiData.fetch();

    // get location translation
    String currentLocation;
    try {
      currentLocation = Mappings.city['Seoul']!;
    }
    catch (error) {
      print('SYSALERT - ERROR: error during location translation. Error: ${error}');
      currentLocation = 'LOCATION: NULL';
    };

    // get image
    Image iconImage;
    try {
      iconImage = await Image.network(
        apiData.currentData.iconUrl,
        scale: 0.75,
      );
    }
    catch (error) {
      print('SYSALERT - ERROR: error during icon image fetching process. Error: ${error}');
      iconImage = await Image.asset('images/alt.jpeg');
    }

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      // should do error handling for null values here
      'location': currentLocation,
      'description': apiData.currentData.description,
      'iconImage': iconImage,
      'temp': apiData.currentData.temp.floor().toString(),
      'feelsLike': apiData.currentData.feelsLike.floor().toString(),
      'tempMax': apiData.currentData.tempMax.floor().toString(),
      'tempMin': apiData.currentData.tempMin.floor().toString(),
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    prepareLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
          child: SpinKitDualRing(
            color: Colors.white,
            size: 50.0,
          )
      ),
    );
  }
}
