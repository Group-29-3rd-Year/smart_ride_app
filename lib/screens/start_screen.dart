import 'package:flutter/material.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
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
                                          fontWeight: FontWeight.w900,
                                          fontSize: 40,
                                      ),
                        ),
                      ),

                  Container(
                          margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
                            height: size.height *0.50,
                            width: size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                alignment: Alignment.bottomLeft,
                                image: AssetImage("assets/images/busNew.png"),
                                fit: BoxFit.fill,
                              )
                            ),
                  ),

                  Container( //start button
                        margin: EdgeInsets.only(top: 5),
                        //padding: EdgeInsets.only(top: 0, bottom: 0, left: 30, right: 30),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                            primary: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text('Start Ride'),
                        ),
                  ),

                ],
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
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 65,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              BottomNavItem(
                title: "Past Travels",
                botIcon: Icons.history,
                press: () {},
              ),
              
              BottomNavItem(
                title: "Available",
                botIcon: Icons.directions_bus,
                press: () {},
              ),
              
              BottomNavItem(
                title: "Fare Rates",
                botIcon: Icons.corporate_fare,
                press: () {},
              ),
            ]
            
          ),
        ),

    );
  }
}