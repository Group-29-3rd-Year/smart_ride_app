import 'package:flutter/material.dart';
import 'package:smart_ride_app/components/text_field_container.dart';
import 'package:smart_ride_app/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key, 
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility, 
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
          ),
          validator: (text) {
          if (text.isEmpty) {
            return 'Password cannot be empty.';
          }
          return null;
        },
        ),
    );
  }
}
