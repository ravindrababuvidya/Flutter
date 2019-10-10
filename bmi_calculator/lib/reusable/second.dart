import 'package:flutter/material.dart';

class Scrren2 extends StatelessWidget{
  final TextStyle textStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: Center(
        child: FlatButton(
          child: Text(""
              "First Page",
            style: textStyle,
          ),
          onPressed: (){
            Navigator.pushNamed(context, "/first");
          },
        ),
      ),
    );
  }
}