import 'package:flutter/material.dart';
import 'reusable.dart';
import 'iconcontent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

void main() => runApp(BMICalculator());
final Color inactiveColor = Color(0xffB3B0B6);
final Color  activeColor =Color(0xff8D8A91 );
enum  GenderType {
  Male,
  Female,
}
final TextStyle customFontstyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff06112E),
        scaffoldBackgroundColor: Color(0xff0E0120),
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  GenderType selectGender=GenderType.Male;
  double _duelCommandment =1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectGender = GenderType.Male;
                      });
                    },
                    child: ReusableCard(
                      color: selectGender == GenderType.Male ? activeColor : inactiveColor,
                      cardChild: IconContentData(
                        icon: FontAwesomeIcons.mars,
                        gender: "Male",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        selectGender = GenderType.Female;
                      });
                    },
                    child: ReusableCard(
                      color: selectGender == GenderType.Female ? activeColor : inactiveColor,
                      cardChild: IconContentData(
                        icon: FontAwesomeIcons.venus,
                        gender: "Female",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 0,
              child: ReusableCard(
                  color: inactiveColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Height",
                        style: customFontstyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "$_duelCommandment CM",
                        style: customFontstyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Slider(
                        value: _duelCommandment.toDouble(),
                        min: 10.0,
                        max: 300.0,
                        divisions: 10,
                        label: '$_duelCommandment',
                        onChanged: (double newValue) {
                          setState(() {
                            _duelCommandment = newValue;
                          });
                        },

                      ),
                    ],
                  ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(color: inactiveColor),
                ),
                Expanded(
                  child: ReusableCard(color: inactiveColor),
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 10,
                color: Colors.pinkAccent,
                padding: EdgeInsets.all(10.0),



              ),
            )
          ],
        ),
      ),
    );
  }
}
