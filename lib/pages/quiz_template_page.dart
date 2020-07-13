import 'dart:collection';
import 'dart:convert';

import 'package:comic_poc/data/quiz_data.dart';
import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizDummyTemplate extends StatefulWidget {
  String title;
  QuizDummyTemplate({this.title});
  @override
  _QuizDummyTemplate createState() => _QuizDummyTemplate();
}

class _QuizDummyTemplate extends State<QuizDummyTemplate> {
  QuizResponseJson questionList;
  bool isEnableButtonCheck = false;
  PageController _pageController;
  double percenageIndicatorValue;
  bool isEnableContinueButtontext = false;
  bool isCorrectAnswer = false;
  var questionChoiceIndex;
  int correctAnswerCount;
  var questionIndex;
  bool isCheckedAnswerValidation = false;

  Map<int, Color> btncolor = new HashMap();
  @override
  void initState() {
    questionList = QuizResponseJson.fromJson(multipleChoiceQuiz);
    super.initState();
    _pageController = PageController();
    percenageIndicatorValue = (1 / questionList.questionslist.length);

    int i = 0;
    questionList.questionslist[1].choices.forEach((choice) {
      btncolor[i++] = Colors.white;
      //print(i++);
    });
    correctAnswerCount =0;
  }

  void getColors() {
    int i = 0;
    questionList.questionslist[1].choices.forEach((choice) {
      btncolor[i++] = Colors.white;
      //print(i++);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("UI rebuilds");
    return Scaffold(
      appBar: AppBar(
        leading: Text(""),
        title: Text('${widget.title} Quiz'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Container(
                    height: 50,
                    // padding: EdgeInsets.only(top: 50),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        //size: 18,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        print("Close Buttom Cliked");
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  onTap: () {
                    print("Close Buttom Cliked");
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: LinearPercentIndicator(
                  // padding: EdgeInsets.only(top: 50),
                  width: MediaQuery.of(context).size.width * 0.5,
                  lineHeight: 14.0,
                  percent: percenageIndicatorValue,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.cyan,
                ),
              ),
            ],
          ),
        ),
        /*bottom: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(top: 50),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      //size: 18,
                      color: Colors.black,
                    ),
                    onPressed: (){
                      print("Close Buttom Cliked");
                      Navigator.pop(context);
                    },
                  ),
                ),
                onTap: (){
                  print("Close Buttom Cliked");
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: LinearPercentIndicator(
                padding: EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width*0.5,
                lineHeight: 14.0,
                percent: percenageIndicatorValue,
                backgroundColor: Colors.grey,
                progressColor: Colors.cyan,
              ),
            ),
          ],
        ),*/
      ),
      body: Container(
        padding: EdgeInsets.only(top: 100),
        child: PageView.builder(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                        '${index + 1} . ${questionList.questionslist[index].question}'),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.orangeAccent,
                    //height: MediaQuery.of(context).size.height*0.7,
                    child: getChoicesWidget(
                        choices: questionList.questionslist[index].choices,
                        questionIndexValue: index),
                  ),
                ),
              ],
            );
          },
          itemCount: questionList.questionslist.length,
          onPageChanged: (value) {
            print('Page Value Chnaged $value');
            setState(() {
              percenageIndicatorValue =
                  ((value + 1) / questionList.questionslist.length);
            });
          },
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 30, left: 8, right: 8),
        width: MediaQuery.of(context).size.width,
        child: isEnableContinueButtontext
            ? Container(
                //height: 200,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 100,
                       // width: 100,
                        child: Column(
                          children: <Widget>[
                            RichText(
                              text: isCorrectAnswer
                                  ? TextSpan(
                                      text: questionList
                                          .questionslist[questionIndex].success,
                                      style: TextStyle(color: Colors.green))
                                  : TextSpan(
                                      text:
                                          "Correct Answer  : \n ${questionList.questionslist[questionIndex].correctAnswer[0]}",
                                      style: TextStyle(color: Colors.red)),
                            ),
                            /*Text(
                          isCorrectAnswer? questionList.questionslist[questionIndex].success
                              : questionList.questionslist[questionIndex].correctAnswer[0]
                      )*/
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        //width: MediaQuery.of(context).size.width * 0.7,
                        child: RaisedButton(
                          visualDensity: VisualDensity.compact,
                          child: Text("Continue"),
                          color: isCorrectAnswer ? Colors.green : Colors.red,
                          onPressed: () async {
                            var result;
                            Map<String, dynamic> data;
                            isEnableButtonCheck
                                ? {
                                    print("Clicked me"),
                                    setState(() {
                                      isEnableButtonCheck = false;
                                      isEnableContinueButtontext = false;
                                    }),
                                    if( (questionList.questionslist.length-1) == questionIndex){
                                      print("Completes Quiz"),

                                         result = await Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context)=> QuizResultPage(
                                          correctAnswers:correctAnswerCount,
                                          totalQuestions:questionList.questionslist.length),
                                        )),
                                      /*
                                        'message':'Sucess',
                                        'correctAnseersPercent'
                                       */
                                        print(result),
                                         data = json.decode(result),
                                        if(data['message'] ==  'Sucess'){
                                          print(data['correctAnseersPercent']),
                                          if(data['correctAnseersPercent'] <= 1.0 && data['correctAnseersPercent'] >= 0.5){
                                            _pageController.jumpToPage(++questionIndex),
                                          }else{
                                            print(_pageController),
                                            _pageController.jumpToPage(0),
                                          }
                                        }
                                    }else{
                                      _pageController.jumpToPage(++questionIndex),
                                    },

                                    getColors(),
                                    questionChoiceIndex = null,
                                    isCorrectAnswer = false,
                                    questionIndex = null,
                                    isCheckedAnswerValidation = false,
                                  }
                                : print("Please me");
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        icon: isCorrectAnswer
                            ? Icon(
                                Icons.flag,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.flag,
                                color: Colors.red,
                              ),
                      ),
                    )
                  ],
                ),
              )
            : RaisedButton(
                visualDensity: VisualDensity.compact,
                child: Text("Check"),
                color: isEnableButtonCheck ? Colors.green : Colors.blueGrey,
                onPressed: () {
                  /*setState(() {
            isEnableButtonCheck = false;
          });*/
                  isEnableButtonCheck
                      ? {
                          print("Clicked me"),
                          getResultValidation(),
                          setState(() {
                            //isEnableButtonCheck = false;
                            isEnableContinueButtontext = true;
                            isCheckedAnswerValidation = true;
                          }),

                          //_pageController.jumpToPage(1)
                        }
                      : print("Please me");
                },
              ),
      ),
    );
  }

  Widget getChoicesWidget({List<String> choices, int questionIndexValue}) {
    return ListView.builder(
        itemCount: choices.length,
        itemBuilder: (context, index) {
          return Container(
            //height: 50,

            padding: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: btncolor[index],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Text(choices[index]),
              onPressed: () {
                if(!isCheckedAnswerValidation){
                  updateSelectedAnserColor(choiceIndex: index,lengththofChoice: choices.length);
                  setState(() {
                    isEnableButtonCheck = true;
                    setState(() {
                      questionIndex = questionIndexValue;
                    });
                  });
                }
                else{

                }


              },
            ),
          );
        });
  }

  void updateSelectedAnserColor({int choiceIndex,int lengththofChoice}) {


    setState(() {
      for(int j=0;j<lengththofChoice;j++){
        if(choiceIndex == j){
          print('Index value $j');
          btncolor[j] = Colors.blueAccent;
        }else{
          btncolor[j] = Colors.white;
        }

      }

      questionChoiceIndex = choiceIndex;
    });
  }

  void getResultValidation() {
    if (questionList.questionslist[questionIndex].correctAnswer[0] ==
        questionList
            .questionslist[questionIndex].choices[questionChoiceIndex]) {
      setState(() {
        isCorrectAnswer = true;
        ++correctAnswerCount;
      });
    } else {
      setState(() {
        isCorrectAnswer = false;
      });
    }

    /*if(questionList.questionslist[questionIndex].correctAnswer[0].toString() ==
        questionList.questionslist[questionIndex].choices[choiceIndex].toString()){
      print('Correct ${questionList.questionslist[questionIndex].choices[choiceIndex]}');
      print('Correct ${questionList.questionslist[questionIndex].correctAnswer[0].toString()}');
      setState(() {

        btncolor[choiceIndex] = Colors.green;
      });
    }else{
      print('wrong choice ${questionList.questionslist[questionIndex].choices[choiceIndex]}');
      print('answer  correct ${questionList.questionslist[questionIndex].correctAnswer[0].toString()}');
      setState(() {
        btncolor[choiceIndex] = Colors.red;
      });
    }*/
  }
}

class QuizResultPage extends StatelessWidget{
  int correctAnswers;
  int totalQuestions;
  QuizResultPage({this.correctAnswers,this.totalQuestions}){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
           onPressed: (){
            var data = {
              'message':'Sucess',
              'correctAnseersPercent':correctAnswers/totalQuestions,
            };
            Navigator.pop(context,json.encode(data));
           },
        ),
        title: Text("Result"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CircularPercentIndicator(
              radius: 120.0,
              lineWidth: 13.0,
              animation: true,
              percent: (correctAnswers/totalQuestions),
              center: new Text(
                "${((correctAnswers/totalQuestions)*100).floor()}%",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              footer: new Text(
                "Percentage of Quiz",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
          ),
          Text('$correctAnswers correct questions'),
          Text('${totalQuestions-correctAnswers} wrong naswers'),

        ],
      ),
    );
  }
}