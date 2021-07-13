import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/display_argument.dart';
import 'package:weather_app/models/mappings.dart';
import 'package:weather_app/utils/size_config.dart';
import 'package:weather_app/utils/geolocator.dart';
import 'package:weather_app/utils/api_manager.dart';

class Loading extends StatefulWidget {

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  // scaling factors
  MediaQueryData? queryData;
  double scale = 1.0;
  double orthoScale = 1.0;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {

    this.prepareScaling();
    this.prepareLoadData();
    super.didChangeDependencies();
  }

  void prepareScaling() async {

    this.queryData = await MediaQuery.of(context);
    SizeConfig size = SizeConfig(this.queryData?.size.width, this.queryData?.size.height);

    scale = size.scaleFactor;
    orthoScale = size.orthoScale;
  }

  void prepareLoadData() async {

    GeoLocator location = GeoLocator.empty();
    await location.getPosition();

    ApiManager apiData = ApiManager(location.lat, location.lon, scale);
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

    Navigator.pushReplacementNamed(context, '/home', arguments: DisplayArgs(
      scale,
      orthoScale,
      currentLocation,
      apiData.currentData.description,
      apiData.currentData.image!, // iconImage,
      apiData.currentData.temp.floor().toString(),
      apiData.currentData.feelsLike.floor().toString(),
      apiData.currentData.tempMax.floor().toString(),
      apiData.currentData.tempMin.floor().toString(),
      apiData.hourlyData, // list of hourly forecast data
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Center(
                child: Text(
                  '데이터를 가져오고 있습니다',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 30,
                    color: Colors.white,
                  )
                ),
              ),
            ),
            SizedBox(height: 20 * orthoScale),
            Center(
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 50,
                )
            ),
          ],
        ),
      ),
    );
  }
}
