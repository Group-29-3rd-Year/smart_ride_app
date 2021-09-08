import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({ key }) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

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
                    Text("Nipun Silva", style: TextStyle(fontSize: 22, color: Colors.white),),
                    Text("nipun@gmail.com", style: TextStyle(color: Colors.white),),
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
              onTap: (){},
            ),
          ],
        ),
      );
  }
}