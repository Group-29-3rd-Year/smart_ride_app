import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/fare_rates_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';
import 'dart:core';

class PastTravels extends StatefulWidget {
  @override
  _PastTravelsState createState() => _PastTravelsState();
}

class _PastTravelsState extends State<PastTravels> {
  // const PastTravels({
  //   Key key
  // }) : super(key: key);

  List pasttravels = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    this.fetchPastTravels();
  }

  Future fetchPastTravels() async {
    var passengerID = await FlutterSession().get("passengerID");
    print(passengerID);

    // var url = "http://192.168.43.136:5000/passenger/pasttravels";
    //   http.Response response = await http.post(
    //     Uri.parse(url),
    //     headers: <String,String>{
    //         'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String,String>{
    //         "passengerID": passengerID,
    //     })
    //   );

    //   if(response.statusCode == 200) {
    //     var items = jsonDecode(response.body);
    //     print(items);
    //     setState(() {
    //       pasttravels = items;
    //       isLoading = false;
    //     });
    //   }else {
    //     print("non");
    //     setState(() {
    //       pasttravels = [];
    //       isLoading = false;
    //     });
    //   }

    var url = "http://192.168.43.136:5000/passenger/pasttravels"; //have to check with ip and localhost
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      print(items);
      setState(() {
        pasttravels = items;
        isLoading = false;
      });
    } else {
      setState(() {
        pasttravels = [];
        isLoading = false;
      });
    }
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
          "Past Travels",
          style: TextStyle(fontSize: 25),
        ),
        toolbarHeight: size.height * 0.08,
        titleSpacing: 30,
        automaticallyImplyLeading: false,
      ),
      body: getBody(),
      bottomNavigationBar: Container(
        //navigation bar
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
                press: () {},
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

  Widget getBody() {
    if (pasttravels.contains(null) || pasttravels.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
      ));
    }
    return ListView.builder(
        itemCount: pasttravels.length,
        itemBuilder: (context, index) {
          return getCard(pasttravels[index]);
        });
  }

  Widget getCard(item) {
    var cost = "Rs. " + item['cost'].toString();
    var date = item['date'];
    var bus = "Bus No: " + item['bus_number'].toString();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black),
      ),
      child: ListTile(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   side: BorderSide(color: Colors.black),
        // ),
        title: Row(
          children: <Widget>[
            Container(
              width: 150,
              height: 80,
              //color: Colors.blue,
              child: Center(
                child: Text(
                  //"test rs",
                  cost.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Colors.green),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    //"test date",
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //"test bus no",
                    bus.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
