import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/ongoing_map_screen.dart';
import 'package:location/location.dart' as location;
import 'package:geolocator/geolocator.dart' as geo;


class NFC_Connect extends StatefulWidget {
  @override
  _NFC_ConnectState createState() => _NFC_ConnectState();
}

class _NFC_ConnectState extends State<NFC_Connect> {

  void initState() {
    super.initState();
    startTime();
    this.getCurrentStartLocation();
  }

  location.Location _location = location.Location();

// get user start location

  double originLat;
  double originLng;

  Future getCurrentStartLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    setState(() {
      final double originLat = geoposition.latitude;
      final double originLng = geoposition.longitude;

      FlutterSession().set('originLat', originLat);
      FlutterSession().set('originLng', originLng);
    });

  }



  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => OngoingMapScreen()
    )
    ); 
  }

  


  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
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
                  "Connecting...",
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
        //),
      //)
    );
  }
}
