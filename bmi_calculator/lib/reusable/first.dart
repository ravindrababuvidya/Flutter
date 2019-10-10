import 'package:flutter/material.dart';
class Scrren1 extends StatelessWidget{
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
        title: Text("First Page"),
      ),
      body: Center(
        child: FlatButton(
          child: Text(
              "Second Page",
            style: textStyle,
          ),
          onPressed: (){
            Navigator.pushNamed(context, "/second");
          },
        ),
      ),
    );
  }
}