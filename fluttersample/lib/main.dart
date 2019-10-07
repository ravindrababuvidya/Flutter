import 'package:flutter/material.dart';
import 'dart:math';
void main() => runApp(BallPage());
class BallPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("Ask Me Anything"),
          backgroundColor: Colors.blue[900],

        ),
        body: Ball(),
      ),
    );
  }
}

class Ball extends StatefulWidget{
  _BallState createState() => _BallState();
}

class _BallState extends State<Ball>{
  int ballCounterValue = 1;
  changeBall (){
    setState(() {
      ballCounterValue = Random().nextInt(5)+1;
      print(ballCounterValue);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            child: Image.asset("images/ball$ballCounterValue.png"),
            onPressed: (){
              changeBall();
            },
          ),
        )
      ],
    );
  }
}