//import 'dart:math';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geocoder/geocoder.dart' as geocoder;
import 'dart:convert';
import 'dart:core';

class AvailableBusMap extends StatefulWidget {
  const AvailableBusMap({ Key key }) : super(key: key);
  @override
  _AvailableBusMapState createState() => _AvailableBusMapState();
}

class _AvailableBusMapState extends State<AvailableBusMap> {

  List<Marker> locations = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchLocation();
    
  }

    
  Future<Set<Marker>> fetchLocation() async {
    setState(() {
      isLoading = true;
    });

    var url = "http://192.168.43.199:5002/buslocations";
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var items = List<Map<String, dynamic>>.from(json.decode(response.body));
      print(items);
      print(items.length);

      if(items.length > 0) {
        for (int i = 0; i < items.length; i++) {
              Map<String, dynamic> map = items[i];
              var x = (map['latitude']);
              var y = (map['longitude']);
              locations.add(
              Marker(
                markerId: MarkerId('Bus'),
                infoWindow: InfoWindow(title: items[i]['bus_number']),
                position: LatLng(x, y),
              ),
          );
        }
      }
      

      // for(var i=0 ; i< items.length ; i++) {
      //   print(i);
      //     Marker setMarker = Marker(
      //       markerId: MarkerId('Bus'),
      //       infoWindow: InfoWindow(title: items[i]['bus_number']),
      //       position: LatLng(items[i]['latitude'], items[i]['longitude']),
      //       icon: BitmapDescriptor.defaultMarkerWithHue(
      //         BitmapDescriptor.hueAzure,
      //       )
            
      //     );

          
      //     setState(() {
      //       locations.add(setMarker);
      //       locations.add(setMarker);
      //       locations.add(setMarker);
      //       isLoading = false;
      //     });
      // }
    }
    return locations.toSet();
    // else {
    //   setState(() {
    //     locations = [];
    //     isLoading = false;
    //   });
    // }
  }



  LatLng _initialcameraposition = LatLng(6.0535, 80.2210);
  GoogleMapController _controller;
  location.Location _location = location.Location();
  

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) { 
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 16),
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

                child: FutureBuilder(
                  future: fetchLocation(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(target: _initialcameraposition),
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      markers: snapshot.data,
                    );
                    },
                  ),
              
                // child: GoogleMap(
                //     initialCameraPosition: CameraPosition(target: _initialcameraposition),
                //     mapType: MapType.normal,
                //     onMapCreated: _onMapCreated,
                //     myLocationEnabled: true,
                //     scrollGesturesEnabled: true,
                //     zoomGesturesEnabled: true,
                //     tiltGesturesEnabled: true,
                //     myLocationButtonEnabled: false,
                //     mapToolbarEnabled: false,
                    
                //     markers: locations.map((e) => e).toSet(),
                // ),
              ),
              SafeArea(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                      children: <Widget>[
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
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
                           
                      ],
                  ),
                ),
              ),
              
          ],
        ),
        bottomNavigationBar: Container( //navigation bar
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
