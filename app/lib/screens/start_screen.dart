import 'package:flutter/material.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/main_drawer.dart';
import 'package:smart_ride_app/screens/nfc_connect_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

import 'nfc_connect_screen_two.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({ Key key }) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  String date;
  String cost;
  String distance;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold( 
      appBar: AppBar(
        title: Text("Smart Ride"),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
      
                    Container(
                          margin: EdgeInsets.only(top:25, ),
                          child: Text(
                                "Smart Ride",
                                style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40,
                                        ),
                          ),
                        ),
      
                    Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                              height: size.height *0.50,
                              width: size.width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  alignment: Alignment.bottomLeft,
                                  image: AssetImage("assets/images/image.png"),
                                  fit: BoxFit.fill,
                                )
                              ),
                    ),
      
                    Container( //start button
                          //padding: EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
                          // decoration: BoxDecoration(
                          //   color: Colors.blue,
                          //   borderRadius: BorderRadius.circular(20),
                            
                          // ),
      
                          // child: TextButton(
                            
                          //   style: TextButton.styleFrom(
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       side: BorderSide(color: Colors.blue)
                          //     ),
                          //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          //     primary: Colors.white,
                          //     textStyle: const TextStyle(
                          //       fontSize: 30,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          //   onPressed: () {},
                          //   child: const Text('Start Ride'),
                          // ),
      
                          child: RoundedButton(
                            text: "START RIDE",
                            color: kPrimaryColor,
                            press: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) {return NFC_Connect();}
                                )
                              );
                            },
                          ),
      
                    ),
      
                    Container(
                      child: RoundedButton(
                            text: "Pay",
                            color: kPrimaryColor,
                            press: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) {return NFC_Connect_Two();}
                                )
                              );
                            },
                          ),
                    ),
      
                  ],
                ),
              ),
            )
          ],
        ),
      ),

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
}