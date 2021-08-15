import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

class OngoingMapScreen extends StatefulWidget {
  @override
  _OngoingMapScreenState createState() => _OngoingMapScreenState();
}

class _OngoingMapScreenState extends State<OngoingMapScreen> {

  


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            icon: new Icon(Icons.arrow_back),
              color: Colors.white, 
              onPressed: () { 
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) {return StartScreen();})
                  );
              },
              alignment: Alignment(1, 0),
          ),
          leadingWidth: 70,
          title: Text(
            "On Going Travel",
            style: TextStyle(fontSize: 25),
          ),
          
          toolbarHeight: size.height * 0.08,
          titleSpacing: 30,
          automaticallyImplyLeading: false,
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