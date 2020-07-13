import 'dart:async';

import 'package:comic_poc/quiz/main.dart';
import 'package:comic_poc/quiz/result_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class QuizCountDownTimer extends StatefulWidget{
  int quizduration;
  QuizCountDownTimer({this.quizduration}){
    print("QuizCountDownTimer Stateful Widget");
  }

  @override
  _QuizCountDownTimerState createState() => _QuizCountDownTimerState();
}

class _QuizCountDownTimerState extends State<QuizCountDownTimer> {
  int timer ;
  String showtimer;
  bool canceltimer = false;
  int durationOfQuiz;


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    timer = widget.quizduration;
    durationOfQuiz =0;
    starttimer();
  }
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          print("Timer Value Reached Low");
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          durationOfQuiz +=1;
          timer = timer - 1;
          setState(() {
            durationOfQuizSpended = durationOfQuiz;
          });

        }
        showtimer = getTimeString(timer);
      });
    });
  }
  void stopTime(){
    setState(() {
      canceltimer = true;
    });
  }

  String getTimeString(int value) {
    final int hour = value ~/ 3600;
    final int minutes = (value % 3600)~/60;
    final int seconds = value % 60;
    return '${hour.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }

  void nextquestion() {
    //widget.autoSubmit;
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => ResultPage(
          userAnswersList: answoersList,
          actualQuestionAndAnswers: questionsMap,
         // comicBookId: comicBookId,

          durationOfQuizSpended: durationOfQuiz,
      ),
    );
    Navigator.pushReplacement(context, route);
    //starttimer();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }


  @override
  Widget build(BuildContext context1) {
    print("Quiz Rebuiled");
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:Row(
        children: <Widget>[
          Container(
            child: IconButton(
              icon:
                canceltimer ?
                Icon(
                  Icons.pause_circle_outline,
                  color: Colors.orange,
                ):Icon(
                  Icons.pause_circle_outline,
                  color: Colors.orange,
                ),
              onPressed: (){
                      starttimer();
              },
            ),
          ),
          Text(
            showtimer == null ? "00:00":showtimer,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Times New Roman',
              color: Colors.orangeAccent
            ),
          ),
        ],
      ),
      /*child: Text(
        '12.30',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold),
      ),*/
    );
  }
}