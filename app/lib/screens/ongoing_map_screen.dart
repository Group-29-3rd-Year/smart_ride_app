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
  bool isMapVisible = false;

  double _originLatitude = 6.066709966979517;
  double _originLongitude = 80.19812604723353;
  double _destLatitude = 6.063610041380509;
  double _destLongitude = 80.21544409936766;
  Map<MarkerId, Marker> markers = {};

  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //this.getUserStartLocation();
    this.getCurrentStartLocation();
    this.createSession();
    //this.getCurrentLocation();
    //this.setCustomMapPin();
    //this.updateUserCurrentBus(bus_id);

    _addMarker(
      LatLng(_originLatitude, _originLongitude),
      "origin",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );

    // Add destination marker
    _addMarker(
      LatLng(_destLatitude, _destLongitude),
      "destination",
      BitmapDescriptor.defaultMarker,
    );

    _getPolyline();

  }

  Future createSession() async {

    await FlutterSession().set('busID', bus_id);

  }

  //update user's current bus
//  Future updateUserCurrentBus(bus_id) async {
//    var passengerID = await FlutterSession().get("passengerID");
//    print(passengerID);
//    print(bus_id);
//
//    var url = "http://192.168.43.136:5000/passenger/ongoingmap/updateUserCurrentBus";
//    http.Response response = await http.post(Uri.parse(url),
//        headers: <String, String>{
//          'Content-Type': 'application/json; charset=UTF-8',
//        },
//        body: jsonEncode(<String, String>{
//          "bus_id": bus_id,
//          "passengerID": passengerID,
//        }));
//
//    var data = response.body;
//    print(data);
//
//  }
  

  // set map initial posision
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(6.0535, 80.2210),
  );

  GoogleMapController _controller;
  location.Location _location = location.Location();
  //final Set<Marker> markers = new Set();

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

    Future.delayed(
        const Duration(milliseconds: 550),
            () => setState(() {isMapVisible = true;})
    );
  }

// get user start location

  static LatLng userStart;

  Future getCurrentStartLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    setState(() {
      userStart = LatLng(geoposition.latitude, geoposition.longitude);
    });

    print(userStart);
  }

  //user running location

  //LatLng userRunningLoc = LatLng(6.068891913835122, 80.19815440635196);

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


//  Set<Marker> getmarkers() {
//    print(userStart);
//    setState(() {
//      markers.add(Marker(
//        //start marker
//        markerId: MarkerId('START'),
//        position: LatLng(userStart.latitude, userStart.longitude),
//        infoWindow: InfoWindow(title: 'START'),
//        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
//        //icon: BitmapDescriptor.defaultMarker
//      ));
//
//      markers.add(Marker(
//        //dest marker
//        markerId: MarkerId('CURRENT'),
//        position: LatLng(),
//        infoWindow: InfoWindow(title: 'CURRENT'),
//        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//        //icon: BitmapDescriptor.defaultMarker
//      ));
//    });
//
//    return markers;
//  }

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
      body:
//      GoogleMap(   //old code
//        mapType: MapType.normal,
//        initialCameraPosition: _initialCameraPosition,
//        onMapCreated: _onMapCreated,
//        myLocationButtonEnabled: false,
//        zoomControlsEnabled: false,
//        myLocationEnabled: true,
//        zoomGesturesEnabled: true,
//        mapToolbarEnabled: false,
//        tiltGesturesEnabled: true,
//        scrollGesturesEnabled: true,
//        polylines: Set<Polyline>.of(polylines.values),
//        markers: Set<Marker>.of(markers.values),
//
//      ),

        AnimatedOpacity(
            curve: Curves.fastOutSlowIn,
            opacity: isMapVisible ? 1.0 : 0,
            duration: Duration(milliseconds: 600),
            child: GoogleMap(
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
              polylines: Set<Polyline>.of(polylines.values),
              markers: Set<Marker>.of(markers.values),
              ),

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

  // This method will add markers to the map based on the LatLng position
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCIH0f4QB94H3wrCkJBebxcTIJ7pU7pdZM",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
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

//     var url = "http://192.168.43.136:5000/passenger/ongoingmap/getuserstart";
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
