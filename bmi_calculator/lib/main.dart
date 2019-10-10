import 'package:bmi_calculator/reusable/mainpage.dart';
import 'package:flutter/material.dart';
import 'reusable.dart';
import 'iconcontent.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'resultspage.dart';
import 'reusable/first.dart';
import 'reusable/mainpage.dart';
import 'reusable/second.dart';

void main() => runApp(BMICalculator());
final Color inactiveColor = Color(0xffB3B0B6);
final Color activeColor = Color(0xff8D8A91);

enum GenderType {
  Male,
  Female,
}


final TextStyle customFontstyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
);
final TextStyle customFontWhiteColor =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.white);

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff06112E),
        scaffoldBackgroundColor: Color(0xff0E0120),
      ),
      /*initialRoute: "/",
      routes: {
        "/": (context) => MainPage(),
        "/first": (context) => Scrren1(),
        "/second": (context) => Scrren2(),
      },*/
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GenderType selectGender = GenderType.Male;
  double _duelCommandment = 50.0;
  double weightValue = 60.0;
  int ageValue = 25;


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
                    onTap: () {
                      setState(() {
                        selectGender = GenderType.Male;
                      });
                    },
                    child: ReusableCard(
                      color: selectGender == GenderType.Male
                          ? activeColor
                          : inactiveColor,
                      cardChild: IconContentData(
                        icon: FontAwesomeIcons.mars,
                        gender: "Male",
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectGender = GenderType.Female;
                      });
                    },
                    child: ReusableCard(
                      color: selectGender == GenderType.Female
                          ? activeColor
                          : inactiveColor,
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
                      "$_duelCommandment cm",
                      style: customFontWhiteColor,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Slider(
                      min: 10.0,
                      max: 300.0,
                      divisions: 10,
                      value: _duelCommandment.toDouble(),
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
                  child: ReusableCard(
                    color: inactiveColor,
                    cardChild: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Weight",
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
                                  onPressed: () {
                                    setState(() {
                                      weightValue--;
                                    });
                                  },
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
                                  onPressed: () {
                                    setState(() {
                                      weightValue++;
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    color: inactiveColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ageValue.toString(),
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
                                onPressed: () {
                                  setState(() {
                                    ageValue--;
                                  });
                                },
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
                                onPressed: () {
                                  setState(() {
                                    ageValue++;
                                  });
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 60.0,
              color: Colors.pinkAccent,
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: FlatButton(
                  child: Text(
                    "Calculate",
                    style: customFontstyle,
                  ),
                  onPressed: () {
                    print("calculate ");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> ResultsPage()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
