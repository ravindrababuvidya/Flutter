import 'package:flutter/material.dart';
import 'package:flutter_quiz/QuizBrain.dart';
QuizBrain quizBrain = new QuizBrain();
void main()=>runApp(MyQuizApp());
class MyQuizApp extends StatefulWidget{
  _MyQuizAppState createState()=> _MyQuizAppState();
}

class _MyQuizAppState extends State<MyQuizApp>{

  void checkAnswers(bool usedCheckAnswer){
    setState(() {
      bool correctAnswer = quizBrain.getQuestionAnswer();
      if(correctAnswer == usedCheckAnswer){
        print("Question is Right ");
      }else{
        print("Question is Wrong ");
      }
      quizBrain.getQuestionCounterNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Center(

                    child: Text(
                      quizBrain.getQuestionText(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                     // padding: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0),
                      color: Colors.green,
                      child: Text(
                          "True",
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
                        checkAnswers(true);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FlatButton(
                      color: Colors.red,
                      child: Text(
                        "False",
                        style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: (){
                       checkAnswers(false);
                      },
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                        Icons.check,
                        color: Colors.green,
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.red,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}