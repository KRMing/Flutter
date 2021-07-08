import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../api/api_manager.dart';
import '../types/mappings.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void fetchData() async {

    ApiManager apiData = ApiManager(id: '1835847');
    await apiData.fetch();

    // get location translation
    String location;
    try {
      location = Mappings.city[apiData.location!]!;
    }
    catch (error) {
      print('SYSALERT - ERROR: error during location translation. Error: ${error}');
      location = 'LOCATION: NULL';
    };

    // get image
    Image iconImage;
    try {
      iconImage = await Image.network(
        apiData.condition!.iconUrl,
        fit: BoxFit.fitHeight,
        color: Colors.grey[200],
      );
    }
    catch (error) {
      print('SYSALERT - ERROR: error during icon image fetching process. Error: ${error}');
      iconImage = await Image.asset('images/alt.jpeg');
    }

    print(iconImage);

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      // should do error handling for null values here
      'location': location,
      'description': apiData.condition?.description,
      'iconImage': iconImage,
      'temp': apiData.temperature?.temp.toString(),
      'feelsLike': apiData.temperature?.feelsLike.toString(),
      'tempMax': apiData.temperature?.tempMax.toString(),
      'tempMin': apiData.temperature?.tempMin.toString(),
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
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
