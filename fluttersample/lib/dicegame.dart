import 'package:flutter/material.dart';
import 'dart:math';
void main()=>runApp(MiDicePage());

class MiDicePage extends StatefulWidget{
  _MiDicePageState createState()  => _MiDicePageState();
}


class _MiDicePageState extends State<MiDicePage>{
  int leftDiceCount =1;
  int rightDiceCount =1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  child: Image.asset("images/dice$leftDiceCount.png"),
                  onPressed: (){

                    diceCount();
                    //leftDiceCount = Random().nextInt(6)+1;

                    print("Left Dice Pressed");
                  },
                ),

              ),
              Expanded(
                child: FlatButton(
                  child: Image.asset("images/dice$rightDiceCount.png"),
                  onPressed: (){

                    diceCount();
                    //rightDiceCount = Random().nextInt(6)+1;


                    print("Right Dice Pressed");
                  },
                ),

              ),
            ],
          ),
        ),
      ),
    );

  }

  diceCount(){
    setState(() {
      rightDiceCount = Random().nextInt(6)+1;
      leftDiceCount = Random().nextInt(6)+1;
    });

  }

}