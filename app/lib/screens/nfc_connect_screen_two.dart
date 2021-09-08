import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/ongoing_map_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:location/location.dart' as location;
import 'package:geolocator/geolocator.dart' as geo;

import 'amount_pay_screen.dart';

class NFC_Connect_Two extends StatefulWidget {

  @override
  _NFC_Connect_TwoState createState() => _NFC_Connect_TwoState();
}

class _NFC_Connect_TwoState extends State<NFC_Connect_Two> {

  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AmountPayScreen()
    )
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: getBody(),

        bottomNavigationBar: Container( //navigation bar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
            ),
            color: KLightNavBarColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              BottomNavItem(
                title: "Past Travels",
                botIcon: Icons.history,
                press: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) {return PastTravels();}
                    )
                  );
                },
              ),
              BottomNavItem(
                title: "Available Busses",
                botIcon: Icons.directions_bus,
                press: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) {return AvailableBusMap();}
                    )
                  );
                },
              ),
              BottomNavItem(
                title: "Fare Rates",
                botIcon: Icons.corporate_fare,
                press: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) {return FareRates();}
                    )
                  );
                },
              ),
            ]
          ),
      ),
    );
  }

  Widget getBody() {
    return(

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Paying...",
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