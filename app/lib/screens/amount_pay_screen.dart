import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

import '../constants.dart';
import 'main_drawer.dart';

class AmountPayScreen extends StatefulWidget {
  const AmountPayScreen({ Key key }) : super(key: key);

  @override
  _AmountPayScreenState createState() => _AmountPayScreenState();
}

class _AmountPayScreenState extends State<AmountPayScreen> {

  @override
  void initState() {
    super.initState();
    this.viewToats();
  }

  Future viewToats() async {

    Fluttertoast.showToast(
              msg: "Payment is completed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

  }

  @override
  Widget build(BuildContext context) {
    var size;
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
      
                    Container( //start button
                          margin: EdgeInsets.only(top: 5),
      
                          child: RoundedButton(
                            text: "Home Page",
                            color: kPrimaryColor,
                            press: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) {return StartScreen();}
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