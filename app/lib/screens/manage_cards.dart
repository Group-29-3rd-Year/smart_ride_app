import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:http/http.dart' as http;

class ManageCards extends StatefulWidget {

  const ManageCards({ Key key }) : super(key: key);

  @override
  _ManageCardsState createState() => _ManageCardsState();
}

class _ManageCardsState extends State<ManageCards> {

  double costPrice = 10.0;
  bool isLoading = false;
  int amount = 0;

  @override
  void initState() {
    super.initState();
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: 'pk_test_51JSOhQFgjMWKE2UzM34TVDvwsCqOv5wqVvQ15DSK2mAY6p0cwqpiycLhhmz8hKCPvI5KibVHKtOmljlc4Xlbqdhe00DoXiBQbl',
      )
    );
  }

  // void _payWithCreditCard() {

  //   InAppPayments.setSquareApplicationId('sq0idp-E-xL46Rgkp0D18AA12ARnw');
  //   InAppPayments.startCardEntryFlow(
  //     onCardNonceRequestSuccess: _success, 
  //     onCardEntryCancel: entryCancel,
  //   );

  // }

  // void _success(CardDetails cardDetails) {

  //   InAppPayments.completeCardEntry(
  //     onCardEntryComplete: _cardEntryComplete
  //   );

  // }

  // void  _cardEntryComplete() {

  // }

  // void entryCancel() {

  //   print("Cancel");

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Cards"),
      ),
      body: Center(
        child: Column(
          children: [
            // ListTile(
            //     leading: Icon(Icons.credit_card),
            //     title: Text("Add Credit Card", style: TextStyle(color: Colors.purple),),
            //     hoverColor: Colors.purple[50], 
            //     contentPadding: EdgeInsets.only(left: 50),
            //     onTap: () {_payWithCreditCard();},
            //   ),
            // ElevatedButton(onPressed: (){_payWithCreditCard();}, child: Text("Pay")),
            ElevatedButton(
              onPressed: (){
                startPayment();
              }, 
              child: Text("Pay")
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startPayment() async {
    StripePayment.setStripeAccount(null);

    amount = (10*100).toInt(); 

    PaymentMethod paymentMethod = PaymentMethod();

    paymentMethod = await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod){
      return paymentMethod;
    } ).catchError((e){
      print(e);
    });

    startDirectCharge(paymentMethod);
  }

  Future<void> startDirectCharge(PaymentMethod paymentMethod) async {
    print("Payment charge started.");

    final http.Response response = await http.post(
      Uri.parse("http://192.168.1.5:5002/pay/ticket_pay")
    );

    if (response.body != null) {
      final paymentIntent = jsonDecode(response.body);
      final status = paymentIntent['paymentIntent']['status'];
      final acct = paymentIntent['stripeAccount'];

      if (status == 'succeeded') {
        print("Payment Done.");
      }
      else {
        StripePayment.setStripeAccount(acct);
        await StripePayment.confirmPaymentIntent(PaymentIntent(
          paymentMethodId: paymentIntent['paymentIntent']['payment_method'],
          clientSecret: paymentIntent['paymentIntent']['client_secret']
        )).then((PaymentIntentResult paymentIntentResult) async {
          final paymentStatus = paymentIntentResult.status;

          if (paymentStatus == 'succeeded') {
            print("Payment Done.");
          }
        });
      }
    }
  }
}