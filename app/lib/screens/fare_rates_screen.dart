import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/available_bus_map_screen.dart';
import 'package:smart_ride_app/screens/past_travel_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:smart_ride_app/widgets/bottom_nav_item.dart';
import 'package:http/http.dart' as http;
// ignore: must_be_immutable
class FareRates extends StatefulWidget {
  @override
  _FareRatesState createState() => _FareRatesState();
}
class _FareRatesState extends State<FareRates> {
  // const FareRates({ 
  //   Key key 
  // }) : super(key: key);

    List fares = [];
    bool isLoading = false;

      @override
  void initState() {
        // TODO: implement initState
    super.initState();
    this.fetchFare();
  }

  Future fetchFare() async {
    setState(() {
      isLoading = true;
    });
    
    var url = "http://192.168.43.199:5002/fare"; //have to check with ip and localhost
    var response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      var items = json.decode(response.body);
      print(items);
      setState(() {
        fares = items;
        isLoading = false;
      });
    }else {
      setState(() {
        fares = [];
        isLoading = false;
      });
    }
  }

    @override
    Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.arrow_back),
            color: Colors.white, 
            onPressed: () { 
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) {return StartScreen();})
                );
            },
            alignment: Alignment(1, 0),
        ),
        leadingWidth: 70,
        title: Text(
          "Fare Rates",
          style: TextStyle(fontSize: 25),
        ),

        toolbarHeight: size.height * 0.08,
        titleSpacing: 30,
        automaticallyImplyLeading: false,
      ),

      body: getBody(),

      bottomNavigationBar: Container( //navigation bar
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
                press: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) {return AvailableBusMap();}
                    )
                  );
                },
              ),
              BottomNavItem(
                title: "Fare Rates",
                botIcon: Icons.corporate_fare,
                press: () {},
              ),
            ]
          ),
      ),


    );
  }
  Widget getBody() {
    if(fares.contains(null) || fares.length < 0 || isLoading) {
      return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),));
    }
    return ListView.builder(
      itemCount: fares.length,
      itemBuilder: (context,index) {
        return getCard(fares[index]);
    });
  }

  Widget getCard(item) {
    var fareKM = item['fare_km'].toString() + " KM";
    var farePrice = "Rs. " + item['fare_price'].toString();
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[

            Row(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 90.0),
                  child: Text(
                    fareKM.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
                SizedBox(width: 20,),

                Text(
                  farePrice.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
