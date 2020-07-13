import 'package:comic_poc/model/answoers_result.dart';
import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:comic_poc/quiz/view_solutions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:collection/collection.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';



class ResultPage extends StatefulWidget {
  List<AnswersResult> userAnswersList = [];
  List<Questionslist_> actualQuestionAndAnswers = [];
  int comicBookId;
  String quizId;
  int durationOfQuizSpended;

  ResultPage(
      {this.actualQuestionAndAnswers,
      this.userAnswersList,
      this.comicBookId,
      this.quizId,
      this.durationOfQuizSpended});

  @override
  _ResultPageState createState() => _ResultPageState(
      userAnswersList: userAnswersList,
      actualQuestionAndAnswers: actualQuestionAndAnswers,
      comicBookId: comicBookId,
      quizId: quizId,durationOfQuizSpended:durationOfQuizSpended);
}

class _ResultPageState extends State<ResultPage> {
  var correctAnswersCount;
  var answersNotAttempted;
  int comicBookId;
  String quizId;
  int durationOfQuizSpended;
  String convertedQuizDuration;
  List<AnswersResult> userAnswersList = [];
  List<Questionslist_> actualQuestionAndAnswers = [];

  List<AnswersResult> answersAfterAllValidations = [];
  double _percentage =0.0;
  _ResultPageState(
      {this.userAnswersList,
      this.actualQuestionAndAnswers,
      this.comicBookId,
      this.quizId,this.durationOfQuizSpended}) {}
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future getResults() async {
    correctAnswersCount = 0;
    answersNotAttempted = 0;
    Function deepEq = const DeepCollectionEquality().equals;
    answersAfterAllValidations = [];

    print('inside getProject Deails');
//    actualQuestionAndAnswers.forEach((f)=>{
//
//
//      print(actualQuestionAndAnswers[0].correctAnsower),
//      print(userAnswersList[0].correctAnswers_),
//      print(deepEq(f.correctAnsower,userAnswersList[0].correctAnswers_))
//
//
//
//    });

    for (var i = 0; i < userAnswersList.length; i++) {
      AnswersResult answerResultFinal = new AnswersResult();

      print('inside for ');

      print('correctAnswers_ inside for ${userAnswersList[i].correctAnswers_}');

      print(actualQuestionAndAnswers[i].question);

      if (actualQuestionAndAnswers[i].questionType == "FILL_IN_THE_BLANKS") {
        answerResultFinal.question = actualQuestionAndAnswers[i].question;

        answerResultFinal.userAnswers = userAnswersList[i].correctAnswers_;
        answerResultFinal.correctAnswers_ =
            actualQuestionAndAnswers[i].correctAnswer;

        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;

        if (actualQuestionAndAnswers[i]
                .correctAnswer[0]
                .toString()
                .toLowerCase() ==
            userAnswersList[i].correctAnswers_[0].toString().toLowerCase()) {
          answerResultFinal.correctOrNot = true;
          answerResultFinal.isNotAttempted = false;
          correctAnswersCount++;
          answersAfterAllValidations.add(answerResultFinal);
        } else if (userAnswersList[i]
                .correctAnswers_[0]
                .toString()
                .toLowerCase() ==
            '') {
          answersNotAttempted++;
          print('anil not attempted ${i}');
          answerResultFinal.isNotAttempted = true;
          answerResultFinal.correctOrNot = false;
          answersAfterAllValidations.add(answerResultFinal);
        } else {
          answerResultFinal.isNotAttempted = false;
          answerResultFinal.correctOrNot = false;
          answersAfterAllValidations.add(answerResultFinal);
        }
      } else {
        print('not fill in the blanks0');

        print(actualQuestionAndAnswers[i].question);
        print(actualQuestionAndAnswers[i].correctAnswer);
        print(userAnswersList[i].correctAnswers_);

        List<String> convertedLowerCaseStrings = [];

        for (var actualCorrectAnswer
            in actualQuestionAndAnswers[i].correctAnswer) {
          convertedLowerCaseStrings
              .add(actualCorrectAnswer.toString().toLowerCase());
        }

        print(deepEq(
            convertedLowerCaseStrings, userAnswersList[i].correctAnswers_));

        answerResultFinal.question = actualQuestionAndAnswers[i].question;
        answerResultFinal.userAnswers = userAnswersList[i].correctAnswers_;
        answerResultFinal.correctAnswers_ =
            actualQuestionAndAnswers[i].correctAnswer;
        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;

        if (deepEq(convertedLowerCaseStrings,
                userAnswersList[i].correctAnswers_) ||
            deepEq(actualQuestionAndAnswers[i].correctAnswer,
                userAnswersList[i].correctAnswers_)) {
          answerResultFinal.correctOrNot = true;
          correctAnswersCount++;
          answersAfterAllValidations.add(answerResultFinal);

          answerResultFinal.isNotAttempted = false;
        } else if (userAnswersList[i]
                .correctAnswers_[0]
                .toString()
                .toLowerCase() ==
            '') {
          print('anil not attempted ${i}');
          answersNotAttempted++;
          answerResultFinal.isNotAttempted = true;
          answerResultFinal.correctOrNot = false;
          answersAfterAllValidations.add(answerResultFinal);
        } else {
          answerResultFinal.isNotAttempted = false;
          answerResultFinal.correctOrNot = false;

          answersAfterAllValidations.add(answerResultFinal);
        }
      }
    }

    return answersAfterAllValidations;
  }

  @override
  void initState() {
    // TODO: implement initState


    for (var i = 0; i < userAnswersList.length; i++) {
      print('inisde init state ${i}');
      print(userAnswersList[i].correctAnswers_);
      print(userAnswersList[i].questionNumber);
    }

    super.initState();
    convertedQuizDuration = getTimeString(durationOfQuizSpended);
  }

  String getTimeString(int value) {
    final int hour = value ~/ 3600;
    final int minutes = (value % 3600)~/60;
    final int seconds = value % 60;
    if(hour >0)
      return '${hour.toString().padLeft(2, "0")} h:${minutes.toString().padLeft(2, "0")} min:${seconds.toString().padLeft(2, "0")} sec';
      else if (minutes > 0)
      return '${minutes.toString().padLeft(2, "0")} min:${seconds.toString().padLeft(2, "0")} sec';
      else
      return '${seconds.toString().padLeft(2, "0")} seconds';


  }

  int totalQuestionsLength = 0;
  @override
  Widget build(BuildContext context) {
    print('inside build of quiz main dart file ');
    print(this.userAnswersList.length);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:  DecorationImage(
            image:_percentage > 50.0 ? NetworkImage(
              "https://giftergo.com/wp-content/uploads/2018/03/Congratulations-GIF27-1.gif-1.gif",

            ):NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ6X8tW3_9KG8vInsGSGFb-1ZcGAs3v_JZZ8g&usqp=CAU",

            ),
                fit: BoxFit.fitWidth,
            //colorFilter: ColorFilter.mode(Colors.grey, BlendMode.luminosity)
          )
        ),
        margin: EdgeInsets.all(8.0),
        child: FutureBuilder(
          builder: (context, resultSnap) {
            if (resultSnap.hasData) {
              //print('project snapshot data is: ${projectSnap.data}');
              totalQuestionsLength = resultSnap.data.length;
              List<AnswersResult> answersAfterAllValidations = resultSnap.data;

              String jsonTags = jsonEncode(answersAfterAllValidations);
              print('before storeing in firebase');
              print(jsonTags);
              print(answersAfterAllValidations);


              return ListView.builder(
                itemCount: resultSnap.data.length,
                itemBuilder: (context, index) {
                  AnswersResult result_current_question =
                      resultSnap.data[index];

                  print('inside listview builder result page ');
//                print('${result_current_question.userAnswers[index]}');

                  return Column(
                    children: <Widget>[
                      index == 0
                          ?

//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[

                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(left: 15.0, top: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        'Performance :',
                                        //style: title_text_style,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "jjjj",
                                          //style: title_text_style,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, right: 20),
                                          child: Text(
                                            "Revision Descrption",

                                          ),
                                        ),
                                      )
                                    ],
//
//                                        Text('')
                                  ),
                                ),
                                new Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Divider(
                                      color: Colors.black,
                                    )),
                                scoreDashboardUi(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
//                        color: Colors.red,
//                        width: MediaQuery.of(context).size.width*0.5,
                                      child: Container(
                                        child: RaisedButton(
                                          onPressed: () {
                                            MaterialPageRoute route =
                                                MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewSolutions(
                                                userAnswersList:
                                                    userAnswersList,
                                                actualQuestionAndAnswers:
                                                    actualQuestionAndAnswers,
                                              ),
                                            );
                                            Navigator.push(context, route);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Ink(
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xff374ABE),
                                                    Color(0xff64B6FF)
                                                  ],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0)),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 200.0,
                                                  minHeight: 50.0),
                                              alignment: Alignment.center,
                                              child: Text(
                                                "View Solutions",
                                                textAlign: TextAlign.center,

                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                new Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new Divider(
                                      color: Colors.black,
                                    )),
                                statisticsUI()
                              ],
                            )
                          : Container(),

//                             ],
//                           )

//                      index==0 ?

                      /*   Container(



                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[



                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(flex:1,child: Text("Question "+(result_current_question.questionNumber+1).toString()+" : ")),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            result_current_question.question,
                                          style: TextStyle(
                                            fontSize: 15
                                          ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          'Your Answer :'
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:List.generate(result_current_question.userAnswers.length,(index){
                                              return result_current_question.userAnswers[index] !='' &&  result_current_question.userAnswers[index] !=null && result_current_question.userAnswers[index].toString().length!=0 ? Text(result_current_question.userAnswers[index].toString()):Text('Not attempted',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(

                                              ),);
                                            }),

                                          ),
                                        ),
                                      ),
//                              Expanded(
//                                flex: 3,
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Text(
//                                    result_current_question.correctAnswers_.toString(),
//                                    style: TextStyle(
//                                        fontSize: 15
//                                    ),
//                                  ),
//                                ),
//                              ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                            'Actual Answer :'
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:List.generate(result_current_question.correctAnswers_.length,(index){
                                              return Text(result_current_question.correctAnswers_[index].toString(),
                                                textAlign: TextAlign.left,
                                                style: TextStyle(

                                                ),);
                                            }),

                                          ),
                                        ),
                                      ),
//                              Expanded(
//                                flex: 3,
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Text(
//                                    result_current_question.correctAnswers_.toString(),
//                                    style: TextStyle(
//                                        fontSize: 15
//                                    ),
//                                  ),
//                                ),
//                              ),
                                    ],
                                  ),
                                ),
                                !result_current_question.isNotAttempted ?
                                      result_current_question.correctOrNot ?Text(
                                            'Correct'
                                        ):
                                        Text(
                                           'Wrong'
                                       )
                                    :Container()
                                // Widget to display the list of project
                              ],
                            ),
                          ),
                        ),

                      ),*/
                    ],
                  );
                },
              );
            } else {
              return Center(child: Text('Loading...'));
            }
          },
          future: getResults(),
        ),
      ),
    );
  }

  Widget statisticsUI() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Text('Statistics',
//          style: TextStyle(
//              fontSize: 20,
//              fontWeight: FontWeight.bold
//          ),
//
//        ),
//
//

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Statistics',
           // style: title_text_style,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 8.0,
                animation: true,
                percent: correctAnswersCount / totalQuestionsLength,
//                          percent:(correctAnswersCount/totalQuestionsLength).round().roundToDouble(),
                //percent:correctAnswersCount/totalQuestionsLength
                center: new Text(
                  (correctAnswersCount / totalQuestionsLength * 100)
                          .round()
                          .toString() +
                      '''
                          Percent
                          ''',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),

//                          footer: new Text(
//                            correctAnswersCount/totalQuestionsLength  *100>35.0?
//                            "Pass":"Failed",
//                            style:
//                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//                          ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.deepPurpleAccent,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 8.0,
                animation: true,
                percent: correctAnswersCount / totalQuestionsLength,
//                          percent:(correctAnswersCount/totalQuestionsLength).round().roundToDouble(),
                //percent:correctAnswersCount/totalQuestionsLength
                center: new Text(
                 convertedQuizDuration,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
//                          footer: new Text(
//                            correctAnswersCount/totalQuestionsLength  *100>35.0?
//                            "Pass":"Failed",
//                            style:
//                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//                          ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.lightGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget scoreDashboardUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Score and Solutions',
           // style: title_text_style,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: CircularPercentIndicator(
                radius: 160.0,
                lineWidth: 8.0,
                animation: true,
                percent: correctAnswersCount / totalQuestionsLength,
//                          percent:(correctAnswersCount/totalQuestionsLength).round().roundToDouble(),
                //percent:correctAnswersCount/totalQuestionsLength
                center: new Text(
//                  (correctAnswersCount +
//                              (totalQuestionsLength -
//                                  answersNotAttempted -
//                                  correctAnswersCount))
//                          .toString() +
                  correctAnswersCount.toString() +

                      '/' +
                      totalQuestionsLength.toString(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
//                          footer: new Text(
//                            correctAnswersCount/totalQuestionsLength  *100>35.0?
//                            "Pass":"Failed",
//                            style:
//                            new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//                          ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          correctAnswersCount.toString() + ' Correct',
                         // style: resultPage_font_style,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          (totalQuestionsLength -
                                      answersNotAttempted -
                                      correctAnswersCount)
                                  .toString() +
                              ' Incorrect ',
                         // style: resultPage_font_style,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.fast_forward,
                        color: Colors.orangeAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          answersNotAttempted.toString() + ' Not Attempted',
                          //style: resultPage_font_style,
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
