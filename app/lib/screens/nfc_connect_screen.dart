import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/ongoing_map_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
//import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
// import 'package:smart_ride_app/components/rounded_button.dart';
// import 'package:screen_loader/screen_loader.dart';


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
      // appBar: AppBar(
      //     backgroundColor: kPrimaryColor,
      //     leading: IconButton(
      //       icon: new Icon(Icons.arrow_back),
      //         color: Colors.white, 
      //         onPressed: () { 
      //             Navigator.push(
      //               context, 
      //               MaterialPageRoute(builder: (context) {return StartScreen();})
      //             );
      //         },
      //         alignment: Alignment(1, 0),
      //     ),
      //     leadingWidth: 70,
      //     title: Text(
      //       "NFC Connect",
      //       style: TextStyle(fontSize: 25),
      //     ),
          
      //     toolbarHeight: size.height * 0.08,
      //     titleSpacing: 30,
      //     automaticallyImplyLeading: false,
      // ),

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
      //Padding(
      //padding: const EdgeInsets.only(left: 50.0, top: 50.0),
        //child: (

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

              // Container(
              //   height: size.height * 0.3,
              //   width: size.width * 0.35,
              //   alignment: Alignment.center,

              //   child: TextButton(
              //     style: ButtonStyle(
              //       shape: MaterialStateProperty.all(
              //         RoundedRectangleBorder(
              //           side: BorderSide(color: Colors.grey, width: 1),
              //           borderRadius: BorderRadius.circular(30.0)
              //         )
              //       ),
              //       foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              //     ),

              //     onPressed: () {
              //       Navigator.push(
              //         context, 
              //         MaterialPageRoute(
              //           builder: (context) {return StartScreen();}
              //         ),
              //       );
              //     },

              //     child: Row(
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.only(right: 10),
              //           child: Text(
              //             "Cancel",
              //             style: TextStyle(
              //               fontSize: 25,
              //               fontWeight: FontWeight.bold
              //             ),
              //           ),
              //         ) ,
              //         Icon(
              //           Icons.cancel,
              //           size: 40,
              //         )
              //       ],
              //     ),
              //   ),
              // )

              // RoundedButton(
              //   text: "Connect",
              //   color: kPrimaryColor,
              //   press: () {
              //     Navigator.push(
              //       context, 
              //       MaterialPageRoute(
              //         builder: (context) {return OngoingMapScreen();}
              //       ),
              //     );
              //   },
              //   // press: () {
              //   //   FlutterNfcReader.read();
              //   // },
              // ),
            ],
          )
        //),
      //)
    );
  }
}
