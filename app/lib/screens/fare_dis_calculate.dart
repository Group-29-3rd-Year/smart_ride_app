import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:smart_ride_app/screens/fare_details.dart';

class FareDisCalculate extends StatefulWidget {
  @override
  _FareDisCalculateState createState() => _FareDisCalculateState();
}

class _FareDisCalculateState extends State<FareDisCalculate> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.createSession();
    this.getEndLocation();
    startTime();

  }

  double startLat;
  double startLng;
  double endLat;
  double endLng;

  //get user start location using session
  Future createSession() async {


    double originLat = await FlutterSession().get("originLat") as double;
    double originLng = await FlutterSession().get("originLng") as double;

    print("start lat : $originLat");
    print("start lng : $originLng");

    setState(() {
      startLat = originLat;
      startLng = originLng;
    });

  }


  //get end location


  Future getEndLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    setState(() {
      final double originLat = geoposition.latitude;
      final double originLng = geoposition.longitude;

    });

  }

  //animation time
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Fare_Details()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    //var size = MediaQuery.of(context).size;
    return(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Calculating...",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              margin: EdgeInsets.only(bottom: 80),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.topCenter,

                child: SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.purple.shade300,
                    valueColor: AlwaysStoppedAnimation(Colors.purple.shade600),
                    strokeWidth: 20,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ],
        )
    );
  }
}
