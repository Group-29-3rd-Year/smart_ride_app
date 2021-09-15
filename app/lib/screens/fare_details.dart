import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

class Fare_Details extends StatefulWidget {
  @override
  _Fare_DetailsState createState() => _Fare_DetailsState();
}

class _Fare_DetailsState extends State<Fare_Details> {
  
  var travelDistance;
  var travelPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getDetails();
  }

  Future getDetails() async {
    var distance = await FlutterSession().get("travelDistance");
    print(distance);
    var price = await FlutterSession().get("farePrice");
    print(price);

    setState(() {
      travelDistance = distance;
      travelPrice = price;
    });
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Thank You !",
                        style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            color: KMyLocation,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 80),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Traveled Distance",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "$travelDistance KM",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Travel Cost",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Rs. $travelPrice",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                    ),

                    Container(
                      child: RoundedButton(
                        text: "Pay",
                        color: kPrimaryColor,
                        press: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
