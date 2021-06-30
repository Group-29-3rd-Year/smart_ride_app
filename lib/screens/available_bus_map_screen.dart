//import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/constraints.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';

class AvailableBusMap extends StatefulWidget {
  const AvailableBusMap({ Key key }) : super(key: key);

  @override
  _AvailableBusMapState createState() => _AvailableBusMapState();
}

class _AvailableBusMapState extends State<AvailableBusMap> {

  LatLng _initialcameraposition = LatLng(6.0535, 80.2210);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) { 
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 15),
          ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      
        body: Stack(
          children: <Widget>[
            Container(
                height: size.height,
                child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: _initialcameraposition),
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    myLocationEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,

                    
                ),
              ),

              SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20),
                  child: Row(
                      children: <Widget>[
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: SShadowColor,
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
                            
                            // Padding(
                            //       padding: const EdgeInsets.symmetric(vertical: 20.0),
                            //       child: Text(
                            //         "Available Busses",
                            //         textAlign: TextAlign.center,
                            //         style: Theme.of(context)
                            //                   .textTheme
                            //                   .headline4
                            //                   .copyWith(
                            //                  fontWeight: FontWeight.w900,
                            //                  fontSize: 25,
                            //                 ),
                                      
                            //       ),
                            // ),
                      ],
                  ),
                ),
              ),

              
          ],
        ),

        bottomNavigationBar: Container( //navigation bar
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
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
                press: () {},
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


// another way

// class AvailableBusMap extends StatefulWidget {
//   @override
//   _AvailableBusMapState createState() => _AvailableBusMapState();
// }

// class _AvailableBusMapState extends State<AvailableBusMap> {
//   GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Maps Sample App'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }


//normal scaffold

// class AvailableBusMap extends StatelessWidget {
//   const AvailableBusMap({ 
//     Key key 
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                       children: <Widget>[
                          
//                           Container(
//                                   height: 50,
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: SShadowColor,
//                                   ),
//                               child: IconButton(
//                                   icon: new Icon(Icons.arrow_back),
//                                   color: Colors.black, 
//                                   onPressed: () { 
//                                     Navigator.push(
//                                     context, 
//                                       MaterialPageRoute(builder: (context) {return StartScreen();})
//                                     );
//                                   },
//                               ),
//                           ),

//                           Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 20.0),
//                               child: Text(
//                                 "Available Busses",
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context)
//                                           .textTheme
//                                           .headline4
//                                           .copyWith(
//                                          fontWeight: FontWeight.w900,
//                                          fontSize: 25,
//                                         ),
                                
//                             ),
//                           ),

//                       ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: Container( //navigation bar
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//             ),
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           height: 65,
          
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[

//               BottomNavItem(
//                 title: "Past Travels",
//                 botIcon: Icons.history,
//                 press: () {
//                   Navigator.push(
//                     context, 
//                     MaterialPageRoute(
//                       builder: (context) {return PastTravels();}
//                     )
//                   );
//                 },
//               ),
              
//               BottomNavItem(
//                 title: "Available Busses",
//                 botIcon: Icons.directions_bus,
//                 press: () {},
//               ),
              
//               BottomNavItem(
//                 title: "Fare Rates",
//                 botIcon: Icons.corporate_fare,
//                 press: () {
//                   Navigator.push(
//                     context, 
//                     MaterialPageRoute(
//                       builder: (context) {return FareRates();}
//                     )
//                   );
//                 },
//               ),
//             ]
            
//           ),
//         ),
//     );
//   }
// }

