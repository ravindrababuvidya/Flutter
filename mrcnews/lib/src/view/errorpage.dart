import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(

        children: <Widget>[
          Center(
            child: Text(
              "Page Not Found"
            ),
          ),
          RaisedButton(
            onPressed:()=>Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false),
          )
        ],
      ),
    );
  }
}