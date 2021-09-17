import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/nfc_connect_screen_two.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

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

  Future payCost() async {

    var passengerID = await FlutterSession().get("passengerID");

    var busID = await FlutterSession().get("busID");

    // final DateTime now = DateTime.now();
    // final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // final String date = formatter.format(now);

    var url = "http://192.168.1.6:5000/passenger/add/enterPaymentDetails";
    http.Response response = await http.post(Uri.parse(url),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        "passengerID": passengerID,
        "cost": travelPrice,
        "busID": busID
      })
    );

    var data = response.body;
    if (data == '"Success"') {
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) {return NFC_Connect_Two();}
        )
      );
    } else {
      Fluttertoast.showToast(
        msg: "Payment is failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    }

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The System Back Button is Deactivated')));
        return false;
      },
      child: Scaffold(
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
                          press: () {
                            payCost();
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),      
      ),
    );
  }
}

