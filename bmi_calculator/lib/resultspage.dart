import 'package:flutter/material.dart';
class ResultsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Center(
        child: Text(
          "BMI Calculator Result coming soon !",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }
}