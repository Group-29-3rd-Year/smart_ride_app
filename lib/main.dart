import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Good Morning Janith,",
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(
                                  fontWeight: FontWeight.w900
                              ),
                  ),
                )
              )
            ],
          ),
      );
  }
}

