import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
//import 'package:flutter/services.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/ongoing_map_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
//import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
// import 'package:smart_ride_app/components/rounded_button.dart';
// import 'package:screen_loader/screen_loader.dart';
import 'package:location/location.dart' as location;
import 'package:geolocator/geolocator.dart' as geo;


class NFC_Connect extends StatefulWidget {
  @override
  _NFC_ConnectState createState() => _NFC_ConnectState();
}

class _NFC_ConnectState extends State<NFC_Connect> {

  // Future<void> startNFC() async {
  //   NfcData response;

  //   setState(() {
  //     var _nfcData = NfcData();
  //     _nfcData.status = NFCStatus.reading;
  //   });

  //   print('NFC: Scan started');

  //   try {
  //     print('NFC: Scan readed NFC tag');
  //     response = (await FlutterNfcReader.read) as NfcData;
  //   } on PlatformException {
  //     print('NFC: Scan stopped exception');
  //   }
  //   setState(() {
  //     var _nfcData = response;
  //   });
  // }
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


//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0),
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     primary: Colors.black,
//                     onSurface: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(2.0)),
//
//                     )
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) {return StartScreen();}
//                         )
//                     );
//                   },
//                   child: Text(
//                       'Cancel',
//                        style: TextStyle(
//                          fontSize: 30,
//                          fontWeight: FontWeight.bold,
//                          color: Colors.red,
//                        ),
//                   ),
//                   // press: () {
//                   //   FlutterNfcReader.read();
//                   // },
//                 ),
//               ),
            ],
          )
        //),
      //)
    );
  }
}
