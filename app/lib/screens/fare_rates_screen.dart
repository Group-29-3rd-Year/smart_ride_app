import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable

class FareRates extends StatefulWidget {
  @override
  _FareRatesState createState() => _FareRatesState();
}


class _FareRatesState extends State<FareRates> {
  // const FareRates({ 
  //   Key key 
  // }) : super(key: key);


  // ignore: deprecated_member_use
  List<Fares> _fares = List<Fares>();
 
 @override
 // ignore: must_call_super
  void initState() {
 
   fetchData().then((value){
       _fares.addAll(value);
     });
   }
 
  Future<List<Fares>> fetchData() async{
    // ignore: deprecated_member_use
    var fares = List<Fares>();
    //var url ='http://localhost:5002/fare';
    var response = await http.get(Uri.parse('http://localhost:5002/fare'));
    var jsonMembers = json.decode(response.body);
    setState(() {
      fares =  jsonMembers.map<Fares>((json) => new Fares.fromJson(json)).toList();
    });
    return fares;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Column(
                children: <Widget>[
                  Row(
                      children: <Widget>[
                            
                          Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: KScaffoldColor,
                                  ),
                              child: IconButton(
                                  icon: new Icon(Icons.arrow_back),
                                  color: Colors.black, 
                                  onPressed: () { 
                                    Navigator.push(
                                    context, 
                                      MaterialPageRoute(builder: (context) {return StartScreen();})
                                    );
                                  },
                              ),
                          ),

                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                "Fare Rates",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  color: Colors.black
                                ),
                            ),
                          ),

                      ],
                  ),
                 
                  
                ],
              ),
            ),
          ),
        ],
        body: getBody();
      ),

      // bottomNavigationBar: Container( //navigation bar
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(30),
      //               topRight: Radius.circular(30),
      //       ),
      //       color: KLightNavBarColor,
      //     ),
      //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //     height: 65,
          
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[

      //         BottomNavItem(
      //           title: "Past Travels",
      //           botIcon: Icons.history,
      //           press: () {
      //             Navigator.push(
      //               context, 
      //               MaterialPageRoute(
      //                 builder: (context) {return PastTravels();}
      //               )
      //             );
      //           },
      //         ),
              
      //         BottomNavItem(
      //           title: "Available Busses",
      //           botIcon: Icons.directions_bus,
      //           press: () {
      //             Navigator.push(
      //               context, 
      //               MaterialPageRoute(
      //                 builder: (context) {return AvailableBusMap();}
      //               )
      //             );
      //           },
      //         ),
              
      //         BottomNavItem(
      //           title: "Fare Rates",
      //           botIcon: Icons.corporate_fare,
      //           press: () {},
      //         ),
      //       ]
            
      //     ),
      // ),
    );
  }

  
}

class Fares {
  int fare_km;
  int fare_price;

  Fares(this.fare_km, this.fare_price);
  Fares.fromJson(Map<int, dynamic>json) {
    fare_km = json['fare_km'];
    fare_price = json['fare_price'];
  }
}