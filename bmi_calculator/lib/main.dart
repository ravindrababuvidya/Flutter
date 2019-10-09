import 'package:flutter/material.dart';
import 'reusable.dart';
import 'iconcontent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(BMICalculator());

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
                  child: ReusableCard(
                    color: Color(0xff194135),
                    cardChild: IconContentData(
                      icon: FontAwesomeIcons.mars,
                      gender: "Male",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: Color(0xff194135),
                    cardChild: IconContentData(
                      icon: FontAwesomeIcons.venus,
                      gender: "Female",
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              flex: 0,
              child: ReusableCard(color: Color(0xff194135)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(color: Color(0xff194135)),
                ),
                Expanded(
                  child: ReusableCard(color: Color(0xff194135)),
                ),
              ],
            ),
            Expanded(
              child: Container(
                height: 10,
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
