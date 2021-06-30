import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:signup/Screens/Login/components/background.dart';
// import 'package:signup/Screens/Signup/signup_screen.dart';
// import 'package:signup/components/already_have_%20an_account_check.dart';
// import 'package:signup/components/rounded_button.dart';
// import 'package:signup/components/rounded_input_field.dart';
// import 'package:signup/components/rounded_password_field.dart';
// import 'package:signup/components/text_field_container.dart';
// import 'package:signup/constants.dart';
import 'package:smart_ride_app/components/already_have_an_account_check.dart';
import 'package:smart_ride_app/components/rounded_button.dart';
import 'package:smart_ride_app/components/rounded_input_field.dart';
import 'package:smart_ride_app/components/rounded_password_field.dart';
import 'package:smart_ride_app/screens/login/components/background.dart';
import 'package:smart_ride_app/screens/signup/signup_screen.dart';


class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03,),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height*0.43,  
            ),
            SizedBox(height: size.height * 0.03,),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {},
              icon: Icons.email,
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {},
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

