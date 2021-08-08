import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_ride_app/components/already_have_an_account_check.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/components/rounded_input_field.dart';
import 'package:smart_ride_app/components/rounded_password_field.dart';
import 'package:smart_ride_app/screens/login/components/background.dart';
import 'package:smart_ride_app/screens/signup/signup_screen.dart';
import 'package:smart_ride_app/screens/start_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  String email;
  String pass;

  Future login()async {

    var url = "http://192.168.1.5:5002/add/login";
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String,String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,String>{
          "email": email,
          "password": pass,
        })
    );

    var data = response.body;
    
    if (data== '"Success"') {
      Fluttertoast.showToast(
        msg: "Login Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
      );

      Navigator.push(
        context, 
          MaterialPageRoute(
            builder: (context) {
              return StartScreen();
            },
          ),
      );

    }
    if(data=='"Error"') {
        Fluttertoast.showToast(
        msg: "Username or Password is Incorrect",
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

            SizedBox(height: size.height*0.05,),
            Text(
              "LOGIN", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
              ),
            ),

            SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height*0.43,  
            ),

            SizedBox(height: size.height * 0.03,),
            RoundedInputField(
              hintText: "Your Email",
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

            RoundedButton(
              text: "LOGIN",
              press: () {
                login();
              },
            ),

            SizedBox(height: size.height * 0.03,),
            AlreadyHaveAnAccountCheck(
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

            SizedBox(height: size.height*0.01,),
          ],
        ),
      ),
    );
  }
}

