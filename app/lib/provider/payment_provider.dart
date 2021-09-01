import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentProvider with ChangeNotifier{
  
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey();
  PaymentMethod _paymentMethod = PaymentMethod();

  PaymentProvider.initialize(){
    StripePayment.setOptions(
      StripeOptions(publishableKey: "pk_test_51JSOhQFgjMWKE2UzM34TVDvwsCqOv5wqVvQ15DSK2mAY6p0cwqpiycLhhmz8hKCPvI5KibVHKtOmljlc4Xlbqdhe00DoXiBQbl")
    );

    addCard();
  }

  void addCard() {
    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
      _paymentMethod = paymentMethod;
    }).catchError((err){
      print("There was an error: ${err.toString()}");
    });
  }

}