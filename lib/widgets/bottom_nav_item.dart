import 'package:flutter/material.dart';

class BottomNavItem extends StatelessWidget {
  final String title;
  final IconData botIcon;
  final Function press;
  const BottomNavItem({ 
    Key key, 
    this.title, 
    this.botIcon,
    this.press 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

              Icon(
                botIcon,
                color: Colors.black,
              ),

              Text(
                title, 
                style: TextStyle(
                  color:  Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ), 
              ),

            ]
          ),
      ),
    );
  }
}