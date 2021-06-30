import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:signup/Screens/Login/login_screen.dart';
// import 'package:signup/Screens/Signup/components/background.dart';
// import 'package:signup/Screens/Signup/components/or_divider.dart';
// import 'package:signup/Screens/Signup/components/social_icon.dart';
// import 'package:signup/components/already_have_%20an_account_check.dart';
// import 'package:signup/components/rounded_button.dart';
// import 'package:signup/components/rounded_input_field.dart';
// import 'package:signup/components/rounded_password_field.dart';
import 'package:smart_ride_app/components/already_have_an_account_check.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/components/rounded_input_field.dart';
import 'package:smart_ride_app/components/rounded_password_field.dart';
import 'package:smart_ride_app/screens/login/login_screen.dart';
import 'package:smart_ride_app/screens/signup/components/background.dart';
import 'package:smart_ride_app/screens/signup/components/or_divider.dart';
import 'package:smart_ride_app/screens/signup/components/social_icon.dart';

class Body extends StatelessWidget {

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
              "SIGN UP", 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height*0.03,),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height*0.5,
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value) {},
              icon: Icons.person,
            ),
            RoundedInputField(
              hintText: "Phone Number",
              onChanged: (value) {},
              icon: Icons.phone,
            ),
            RoundedInputField(
              hintText: "Email",
              onChanged: (value) {},
              icon: Icons.email,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Card Number",
              onChanged: (value) {},
              icon: Icons.credit_card,
            ),
            RoundedInputField(
              hintText: "Expiry Date",
              onChanged: (value) {},
              icon: Icons.calendar_today,
            ),
            RoundedInputField(
              hintText: "CVN",
              onChanged: (value) {},
              icon: Icons.credit_card,
            ),
            RoundedButton(
              text: "SIGN UP",
              press: () {},
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

