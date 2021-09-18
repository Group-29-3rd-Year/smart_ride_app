import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/login/login_screen.dart';
import 'package:smart_ride_app/screens/signup/signup_screen.dart';
import 'package:smart_ride_app/screens/welcome/components/background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text(
              "WELCOME TO SMARTRIDE",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),

            SizedBox(height: size.height*0.03,),
            Image.asset(
              "assets/images/homeNew.png",
              height: size.height * 0.45,
            ),

            SizedBox(height: size.height*0.03,),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context){
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),

            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),

            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Smartride © 2021",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
