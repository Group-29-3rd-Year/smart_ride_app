import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_ride_app/constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
    Key key, 
    this.iconSrc, 
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc, 
          height: 18, 
          width: 18,
        ),
      ),
    );
  }
}
