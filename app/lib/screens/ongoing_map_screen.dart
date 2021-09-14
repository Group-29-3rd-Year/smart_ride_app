import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_dis_calculate.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geolocator/geolocator.dart' as geo;
import 'dart:math' show cos, sqrt, asin;
import 'package:confirm_dialog/confirm_dialog.dart';

class OngoingMapScreen extends StatefulWidget {
  @override
  _OngoingMapScreenState createState() => _OngoingMapScreenState();
}

class _OngoingMapScreenState extends State<OngoingMapScreen> {
  var bus_id = 1;
  bool isMapVisible = false;

  double _currentLatitude;
  double _currentLongitude;
  Map<MarkerId, Marker> markers = {};


  // get bus id to session
  //get user start location
  Future createSession() async {

    await FlutterSession().set('busID', bus_id);

    double originLat = await FlutterSession().get("originLat") as double;
    double originLng = await FlutterSession().get("originLng") as double;

    print("start lat : $originLat");
    print("start lng : $originLng");


  }

  //update user's current bus
  Future updateUserCurrentBus() async {
    var passengerID = await FlutterSession().get("passengerID");
    print(passengerID);
    print(bus_id);

    var url = "http://192.168.43.136:5000/passenger/ongoingmap/updateUserCurrentBus";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          "bus_id": bus_id,
          "passengerID": passengerID,
        }));

    var data = response.body;
    print(data);

  }


  // set map initial posision
  static const _initialCameraPosition = CameraPosition(target: LatLng(6.0535, 80.2210),);

  GoogleMapController _controller;
  location.Location _location = location.Location();

  //set on map create
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 16),
        ),
      );
    });

    //for animate map
    Future.delayed(
        const Duration(milliseconds: 550),
            () => setState(() {isMapVisible = true;})
    );
  }


  Future getCurrentStartLocation() async {
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    setState(() {
      _currentLatitude = geoposition.latitude;
      _currentLongitude = geoposition.longitude;

      print("dest lat : $_currentLatitude");
      print("dest lng : $_currentLongitude");

      // Add destination marker
      _addMarker(
        LatLng(_currentLatitude, _currentLongitude),
        "My Location",
        BitmapDescriptor.defaultMarkerWithHue(90),
        "My Location",
      );
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getCurrentStartLocation();
    this.updateUserCurrentBus();
    this.createSession();


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
      body:
      AnimatedOpacity(
        curve: Curves.fastOutSlowIn,
        opacity: isMapVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 600),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
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
              markers: Set<Marker>.of(markers.values),
            ),

            Positioned(
              bottom: 20,
              child: SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    child: Text(
                        "End Tour",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        )
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: KMyLocation.withOpacity(0.9),
                      side: BorderSide(color: KMyLocation, width: 0.5),
                      elevation: 20,

                      minimumSize: Size(150, 50),
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () async {
                      if (await confirm(
                        context,
                        title: Text('Confirm'),
                        content: Text('End Tour?'),
                        textOK: Text('Yes'),
                        textCancel: Text('No'),
                      )) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return FareDisCalculate();
                        }));
                        return print('pressedOK');
                      }
                      return print('pressedCancel');
                    },
                  ),
                ),
              ),
            )
          ],

        ),

      ),



      //my location button
      floatingActionButton: FloatingActionButton(
        backgroundColor: KMyLocation,
        foregroundColor: Colors.black,
        onPressed: () => _controller.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.my_location),
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
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor, String name) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position, infoWindow: InfoWindow(title: name));
    markers[markerId] = marker;
  }

}
