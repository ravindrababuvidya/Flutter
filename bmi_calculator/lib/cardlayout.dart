import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardLayout extends StatefulWidget {
  final String catageroy;
  final String weightValue;
  CardLayout({this.catageroy, this.weightValue});
  CardLayoutState createState() => CardLayoutState();
}

class CardLayoutState extends State<CardLayout> {
  final String catageroy;
  final String weightValue;

  //final IconData iconData = ;
  CardLayoutState({this.catageroy, this.weightValue});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          catageroy,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weightValue.toString(),
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  FontAwesomeIcons.minusCircle,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: FlatButton(
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  FontAwesomeIcons.plusCircle,
                  size: 40.0,
                ),
                onPressed: () {},
              ),
            )
          ],
        )
      ],
    );
  }
}
