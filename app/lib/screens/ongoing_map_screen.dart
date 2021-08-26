import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geolocator/geolocator.dart' as geo;

class OngoingMapScreen extends StatefulWidget {
  @override
  _OngoingMapScreenState createState() => _OngoingMapScreenState();
}

class _OngoingMapScreenState extends State<OngoingMapScreen> {

  var bus_id = 1;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.getUserStartLocation();
    this.getCurrentStartLocation();
    //this.getCurrentLocation();
    //this.setCustomMapPin();
    this.updateUserCurrentBus(bus_id);
    polylinePoints = PolylinePoints();

  }

  //update user's current bus
  Future updateUserCurrentBus(bus_id) async {
    var passengerID = await FlutterSession().get("passengerID");
    print(passengerID);
    print(bus_id);

    var url = "http://192.168.43.199:5002/ongoingmap/updateUserCurrentBus";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "bus_id": bus_id,
          "passengerID": passengerID,
        }));

    var data = response.body;
    print(data);

  }

  //get bus current location
  // Future getUserStartLocation() async {
  //   var bus_id = "1";
  //   print(bus_id);

  //   var url = "http://192.168.43.199:5002/ongoingmap/getuserstart";
  //   http.Response response = await http.post(Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         "bus_id": bus_id,
  //       }));

  //   var data = response.body;
  //   var x = double.parse(data['latitude']);
  //   var y = double.parse(data[1]);
  //   print(x);
  //   print(y);

  //   setState(() {
  //     userStart = LatLng(x, y);
  //   });

  // }

  // set map initial posision
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.0535, 80.2210),
  );

  GoogleMapController _controller;
  location.Location _location = location.Location();
  final Set<Marker> markers = new Set();

  

  //set onmap create
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16),
        ),
      );
      print(l.latitude);
      print(l.longitude);
     
    });

    setPolylines();
    
  }

  
  // get user start location

  LatLng userStart;

  getCurrentStartLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    setState(() {
      userStart = LatLng(geoposition.latitude, geoposition.longitude);
    });

    print(userStart);
    print(userStart.latitude);
    print(userStart.longitude);
  }

  //user running location

  LatLng userRunningLoc = LatLng(6.068891913835122, 80.19815440635196);

  // getCurrentLocation() async {
  //   final geoposition = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: geo.LocationAccuracy.high);

  //   setState(() {
  //     userRunningLoc = LatLng(geoposition.latitude, geoposition.longitude);
  //   });

  //   print(userRunningLoc);
  //   print(userRunningLoc.latitude);
  //   print(userRunningLoc.longitude);
  // }


  //create polylines
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;

  LatLng startLocation;
  LatLng currentLocation;

  void setInitialLocation() {
    startLocation = LatLng(
      userStart.latitude,
      userStart.longitude
    );

    currentLocation = LatLng(
      userRunningLoc.latitude,
      userRunningLoc.longitude
    );
  }


  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyC6KymOCqvPCbN4zMeoWK87g1o78HhbLPE",
      PointLatLng(
        startLocation.latitude,
        startLocation.longitude
      ),
      PointLatLng(
        currentLocation.latitude,
        currentLocation.longitude
      )
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(
          Polyline(
            width: 10,
            polylineId: PolylineId('polyLine'),
            color: Color(0xFF08A5CB),
            points: polylineCoordinates
          )
        );
      });
    }
  }

  //set markers
  
  // first method custom icon
  // BitmapDescriptor startLocationIcon;

  // setCustomMapPin() async {
  //   startLocationIcon = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(),
  //       'assets/images/start_map_marker.png');
  // }

  // second method custom icon
  // BitmapDescriptor customIcon;

  // createMarker(context) {
  //   if (customIcon == null) {
  //     ImageConfiguration configuration = createLocalImageConfiguration(context);
  //     BitmapDescriptor.fromAssetImage(configuration, "assets/images/start_map_marker.png")
  //         .then((icon) {
  //       setState(() {
  //         customIcon = icon;
  //       });
  //     });
  //   }
  // }

  Set<Marker> getmarkers() {
    print(userStart);
    setState(() {
      markers.add(Marker( //start marker
        markerId: MarkerId('START'),
        position: LatLng(userStart.latitude, userStart.longitude),
        infoWindow: InfoWindow(title: 'START'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        //icon: BitmapDescriptor.defaultMarker
        
      ));

      markers.add(Marker( //current running marker
        markerId: MarkerId('CURRENT LOC'),
        position: LatLng(userRunningLoc.latitude, userRunningLoc.longitude),
        infoWindow: InfoWindow(title: 'CURRENT LOC'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        //icon: BitmapDescriptor.defaultMarker
        
      ));
      
    });

    return markers;
  }

  

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
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StartScreen();
            }));
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

      //body map
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        mapToolbarEnabled: false,
        tiltGesturesEnabled: true,
        scrollGesturesEnabled: true,
        markers: getmarkers(),
        polylines: _polylines,
      ),

      //my location button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _controller.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),

      //navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PastTravels();
                  }));
                },
              ),
              BottomNavItem(
                title: "Available Busses",
                botIcon: Icons.directions_bus,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AvailableBusMap();
                  }));
                },
              ),
              BottomNavItem(
                title: "Fare Rates",
                botIcon: Icons.corporate_fare,
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FareRates();
                  }));
                },
              ),
            ]),
      ),
    );
  }
}



















// orignal one


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:smart_ride_app/constants.dart';
// import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
// import 'package:smart_ride_app/screens/fare_rates_screen.dart';
// import 'package:smart_ride_app/screens/past_travel_screen.dart';
// import 'package:smart_ride_app/screens/start_screen.dart';
// import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as location;

// class OngoingMapScreen extends StatefulWidget {
//   @override
//   _OngoingMapScreenState createState() => _OngoingMapScreenState();
// }

// class _OngoingMapScreenState extends State<OngoingMapScreen> {
//   var bus_id = 1;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.getUserCurrentLocation();
//   }

//   //get bus current location
//   Future getUserCurrentLocation() async {
//     var bus_id = "1";
//     print(bus_id);

//     var url = "http://192.168.43.199:5002/ongoingmap/getuserstart";
//     http.Response response = await http.post(Uri.parse(url),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           "bus_id": bus_id,
//         }));

//     var data = response.body;
//     print(data);

//     // setState(() {
//     //   Marker(
//     //     markerId: MarkerId('Bus'),
//     //     position: LatLng(double.parse(x), double.parse(y)),
//     //     infoWindow: InfoWindow(title: 'Start'),
//     //     //position: LatLng(data[0]['latitude'], data[0]['longitude']),
//     //   );
//     // });
//   }

//   // set map initial posision
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(6.0535, 80.2210),
//   );

//   GoogleMapController _controller;
//   location.Location _location = location.Location();

//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _cntlr;
//     _location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         leading: IconButton(
//           icon: new Icon(Icons.arrow_back),
//           color: Colors.white,
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return StartScreen();
//             }));
//           },
//           alignment: Alignment(1, 0),
//         ),
//         leadingWidth: 70,
//         title: Text(
//           "On Going Travel",
//           style: TextStyle(fontSize: 25),
//         ),
//         toolbarHeight: size.height * 0.08,
//         titleSpacing: 30,
//         automaticallyImplyLeading: false,
//       ),

//       //body map
//       body: GoogleMap(
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         initialCameraPosition: _initialCameraPosition,
//         onMapCreated: _onMapCreated,
//       ),

//       //my location button
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).primaryColor,
//         foregroundColor: Colors.black,
//         onPressed: () => _controller.animateCamera(
//           CameraUpdate.newCameraPosition(_initialCameraPosition),
//         ),
//         child: const Icon(Icons.center_focus_strong),
//       ),

//       //navigation bar
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//           ),
//           color: KLightNavBarColor,
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         height: 65,
//         child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               BottomNavItem(
//                 title: "Past Travels",
//                 botIcon: Icons.history,
//                 press: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return PastTravels();
//                   }));
//                 },
//               ),
//               BottomNavItem(
//                 title: "Available Busses",
//                 botIcon: Icons.directions_bus,
//                 press: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return AvailableBusMap();
//                   }));
//                 },
//               ),
//               BottomNavItem(
//                 title: "Fare Rates",
//                 botIcon: Icons.corporate_fare,
//                 press: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                     return FareRates();
//                   }));
//                 },
//               ),
//             ]),
//       ),
//     );
//   }
// }
