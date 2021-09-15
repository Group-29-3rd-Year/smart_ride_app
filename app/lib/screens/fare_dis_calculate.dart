import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/screens/fare_details.dart';
import 'package:http/http.dart' as http;

class FareDisCalculate extends StatefulWidget {
  @override
  _FareDisCalculateState createState() => _FareDisCalculateState();
}

class _FareDisCalculateState extends State<FareDisCalculate> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchLocationsAndFareCalculate();
    startTime();

  }


  Future fetchLocationsAndFareCalculate() async {

    //get start location by session
    double startLat = await FlutterSession().get("originLat") as double;
    double startLng = await FlutterSession().get("originLng") as double;

    print("Start lat  : $startLat");
    print("Start lng  : $startLng");

    //get current dest location by geo
    final geoposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);

    double endLat = geoposition.latitude;
    double endLng = geoposition.longitude;

    print("Destination lat  : $endLat");
    print("Destination lng  : $endLng");


    PolylinePoints polylinePoints;
    List<LatLng> polylineCoordinates = [];
    Map<PolylineId, Polyline> polylines = {};

    // Create the polylines for showing the route between two places
    _createPolylines(double startLatitude,double startLongitude,double destinationLatitude,double destinationLongitude,) async {
        polylinePoints = PolylinePoints();
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          "AIzaSyCIH0f4QB94H3wrCkJBebxcTIJ7pU7pdZM", // Google Maps API Key
          PointLatLng(startLatitude, startLongitude),
          PointLatLng(destinationLatitude, destinationLongitude),
          travelMode: TravelMode.transit,
        );

        if (result.points.isNotEmpty) {
          result.points.forEach((PointLatLng point) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          });
        }

        PolylineId id = PolylineId('poly');
        Polyline polyline = Polyline(
          polylineId: id,
          color: Colors.red,
          points: polylineCoordinates,
          width: 3,
        );
        polylines[id] = polyline;
    }

    await _createPolylines(startLat, startLng, endLat,endLng);

    // Formula for calculating distance between two coordinates
    double _coordinateDistance(lat1, lon1, lat2, lon2) {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    }

    double _placeDistance;
    double totalDistance = 0.0;


    // Calculating the total distance by adding the distance
    // between small segments
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }

    setState(() {
      _placeDistance = double.parse(totalDistance.toStringAsFixed(2));
      print('DISTANCE: $_placeDistance km');
      print(_placeDistance.runtimeType);

    });

    await FlutterSession().set('travelDistance', _placeDistance);

    int roundedDistance = _placeDistance.round();
    print("rounded distance : $roundedDistance");

    if(roundedDistance == 0) {
      roundedDistance = 1;
    }
    else {
      roundedDistance = roundedDistance;
    }

    //calculate fare according to distance
    var url = "http://192.168.43.136:5000/passenger/ongoingmap/gettravelcost";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          "distance": roundedDistance,
        }));

    var data = response.body;

    print("Fare price : $data");
    //set fare price to session
    await FlutterSession().set('farePrice', data);

  }


  //animation time
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Fare_Details()
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    //var size = MediaQuery.of(context).size;
    return(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Calculating...",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              margin: EdgeInsets.only(bottom: 80),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                alignment: Alignment.topCenter,

                child: SizedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.purple.shade300,
                    valueColor: AlwaysStoppedAnimation(Colors.purple.shade600),
                    strokeWidth: 20,
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ],
        )
    );
  }
}
