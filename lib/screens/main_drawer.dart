import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:smart_ride_app/screens/welcome/welcome_screen.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({ key }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  String passengerName; 
  String passengerEmail; 

  @override
  void initState() {
    super.initState();
    this.getDet();
  }

  void _payWithCreditCard() {

    InAppPayments.setSquareApplicationId('sq0idp-E-xL46Rgkp0D18AA12ARnw');
    InAppPayments.startCardEntryFlow(
      onCardNonceRequestSuccess: _success, 
      onCardEntryCancel: entryCancel,
    );

  }

  void _success(CardDetails cardDetails) {

    InAppPayments.completeCardEntry(
      onCardEntryComplete: _cardEntryComplete
    );

  }

  void _cardEntryComplete() {

  }

  void entryCancel() {
    print("Cancel");
  }

  Future getDet() async {

    var passName = await FlutterSession().get("passengerName");
    var passEmail = await FlutterSession().get("passengerEmail"); 

    setState(() {
       passengerName = passName;
       passengerEmail = passEmail;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    Text('Hello, $passengerName', style: TextStyle(fontSize: 22, color: Colors.white),),
                    Text("$passengerEmail", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text("Add Credit Card", style: TextStyle(color: Colors.purple),),
              hoverColor: Colors.purple[50], 
              contentPadding: EdgeInsets.only(left: 50),
              onTap: () {_payWithCreditCard();},
            ),

            ListTile(
              leading: Icon(Icons.arrow_back),
              title: Text("Log out", style: TextStyle(color: Colors.purple),),
              hoverColor: Colors.purple[50], 
              contentPadding: EdgeInsets.only(left: 50),
              onTap: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeScreen();
                        },
                      ),
                    );
              },
            ),
          ],
        ),
      );
  }
}