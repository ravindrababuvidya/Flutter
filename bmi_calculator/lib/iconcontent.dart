import 'package:flutter/material.dart';

class IconContentData extends StatelessWidget {
  final IconData icon;
  final String gender;

  IconContentData({this.icon,this.gender});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Male",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}