import 'package:flutter/material.dart';

class Fare_Details extends StatefulWidget {
  @override
  _Fare_DetailsState createState() => _Fare_DetailsState();
}

class _Fare_DetailsState extends State<Fare_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text(
                 "Fare Data",
               ),
             ],
           ),
        ),
    );
  }
}
