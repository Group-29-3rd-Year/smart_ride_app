import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/amount_pay_screen.dart';

class NFC_Connect_Two extends StatefulWidget {

  @override
  _NFC_Connect_TwoState createState() => _NFC_Connect_TwoState();
}

class _NFC_Connect_TwoState extends State<NFC_Connect_Two> {

  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AmountPayScreen()
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
    return(

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "Paying...",
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
        //),
      //)
    );
  }
}