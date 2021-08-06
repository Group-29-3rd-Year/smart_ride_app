import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_ride_app/components/already_have_an_account_check.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/components/rounded_input_field.dart';
import 'package:smart_ride_app/components/rounded_password_field.dart';
import 'package:smart_ride_app/screens/login/login_screen.dart';
import 'package:smart_ride_app/screens/signup/components/background.dart';
import 'package:smart_ride_app/screens/signup/components/or_divider.dart';
import 'package:smart_ride_app/screens/signup/components/social_icon.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String name;
  String phone;
  String email;
  String pass;

  Future register()async {
    var url = "http://192.168.1.5:5002/add/register";
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
          "uname": name,
          "phone_number": phone,
          "email": email,
          "password": pass,
        })
    );
    
    var data = response.body;
    if (data== "Success") {
      Fluttertoast.showToast(
        msg: "Registration Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );
    } else {
        Fluttertoast.showToast(
        msg: "This User Already Exist",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: size.height*0.06,),
            Text(
              "SIGN UP", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),

            SizedBox(height: size.height*0.03,),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height*0.4,
            ),

            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {
                setState((){
                  name = value;
                });
              },
              icon: Icons.person,
            ),

            RoundedInputField(
              hintText: "Phone Number",
              onChanged: (value) {
                setState((){
                  phone = value;
                });
              },
              icon: Icons.phone,
            ),

            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {
                setState((){
                  email = value;
                });
              },
              icon: Icons.email,
            ),

            RoundedPasswordField(
              onChanged: (value) {
                setState((){
                  pass = value;
                });
              },
            ),

            // RoundedInputField(
            //   hintText: "Card Number",
            //   onChanged: (value) {},
            //   icon: Icons.credit_card,
            // ),

            // RoundedInputField(
            //   hintText: "Expiry Date",
            //   onChanged: (value) {},
            //   icon: Icons.calendar_today,
            // ),

            // RoundedInputField(
            //   hintText: "CVV",
            //   onChanged: (value) {},
            //   icon: Icons.credit_card,
            // ),

            RoundedButton(
              text: "SIGN UP",
              press: () {
                register();
              },
            ),

            SizedBox(height: size.height*0.03,),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),

            OrDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            ),

            SizedBox(height: size.height*0.01,),
            
          ],
        ),
      ),
    );
  }
}

