// import 'package:flutter/material.dart';
// import 'package:smart_ride_app/constraints.dart';
// import 'package:smart_ride_app/screens/start_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Smart Ride Original',
//       theme: ThemeData(
//         fontFamily: "Cairo",
//         scaffoldBackgroundColor: SGreyBackColor,
//         textTheme: Theme.of(context).textTheme.apply(displayColor: STextColor)
//       ),
//       home: Home(),
//     );
//   }
// }

// class Home extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//         return Scaffold(
//           resizeToAvoidBottomInset : false,
//           body: Stack(
//             children: <Widget>[
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(2),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[

//                       Container(
//                         margin: EdgeInsets.only(top:25, ),
//                         child: Text(
//                               "Smart Ride",
//                               style: Theme.of(context)
//                                       .textTheme
//                                       .headline6
//                                       .copyWith(
//                                           fontWeight: FontWeight.w900,
//                                           fontSize: 40,
//                                       ),
//                         ),
//                       ),

//                       Container(
//                         margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
//                           height: size.height *0.35,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               alignment: Alignment.bottomLeft,
//                               image: AssetImage("assets/images/homeNew.png"),
//                               fit: BoxFit.fill,
//                             )
//                           ),
//                       ),
                      
//                       Container(  //username
//                         margin: EdgeInsets.only(top:8, bottom: 5, left: 70, right: 70),
//                         padding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: "User name",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),

//                       Container( //password
//                         margin: EdgeInsets.symmetric(vertical: 0, horizontal: 70),
//                         padding: EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: TextField(
//                           decoration: InputDecoration(
//                             hintText: "Password",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),

//                       Container( //login button
//                         margin: EdgeInsets.only(top: 10),
//                         padding: EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(20),
                          
//                         ),
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//                             primary: Colors.white,
//                             textStyle: const TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context, 
//                               MaterialPageRoute(
//                                 builder: (context) {return StartScreen();}
//                               )
//                             );
//                           },
//                           child: const Text('Sign In'),
//                         ),
//                       ),

                     
//                           Container(
//                             margin: EdgeInsets.only(top: 5),
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 5),
//                               child: Text(
//                                 "Haven't account yet?",
//                                 style: Theme.of(context)
//                                         .textTheme
//                                         .headline6
//                                         .copyWith(
//                                             fontWeight: FontWeight.w900,
//                                             fontSize: 20,
//                                         ),
//                               ),
//                             ),
//                           ),

//                           Container( //signup text
                            
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                 padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
//                                 primary: Colors.blue,
//                                 textStyle: const TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               onPressed: () {},
//                               child: const Text('Sign Up'),
//                             ),
//                           ),
                            
//                             Container(
//                               margin: EdgeInsets.only(top: 50),
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 15),
//                                 child: Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: Container(
//                                     child: Text(
//                                       "smartride © 2021",
//                                         style: Theme.of(context)
//                                           .textTheme
//                                           .headline6
//                                           .copyWith(
//                                               fontWeight: FontWeight.w900,
//                                               fontSize: 20,
//                                           ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//       );
//   }
// }

import 'package:flutter/material.dart';
import 'package:smart_ride_app/constants.dart';
import 'package:smart_ride_app/screens/welcome/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Ride',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: KScaffoldColor,
      ),
      home: WelcomeScreen(),
    );
  }
}

