import 'package:comic_poc/model/answoers_result.dart';
import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:flutter/material.dart';


import 'package:collection/collection.dart';

class ViewSolutions extends StatefulWidget {

  List<AnswersResult> userAnswersList = [];
  List<Questionslist_> actualQuestionAndAnswers = [];

  ViewSolutions({this.userAnswersList,this.actualQuestionAndAnswers});


  @override
  _ViewSolutionsState createState() => _ViewSolutionsState(actualQuestionAndAnswers:actualQuestionAndAnswers,userAnswersList:userAnswersList );
}

class _ViewSolutionsState extends State<ViewSolutions> {
  List<AnswersResult> userAnswersList = [];
  List<Questionslist_> actualQuestionAndAnswers = [];

  _ViewSolutionsState({this.userAnswersList,this.actualQuestionAndAnswers});
//  var correctAnswersCount=0;


  List<AnswersResult> answersAfterAllValidations = [];











//  Future getResults() async {
//    Function deepEq = const DeepCollectionEquality().equals;
//    answersAfterAllValidations = [];
//
//    print('inside getProject Deails');
////    actualQuestionAndAnswers.forEach((f)=>{
////
////
////      print(actualQuestionAndAnswers[0].correctAnsower),
////      print(userAnswersList[0].correctAnswers_),
////      print(deepEq(f.correctAnsower,userAnswersList[0].correctAnswers_))
////
////
////
////    });
//
//    for (var i = 0; i < userAnswersList.length; i++) {
//      AnswersResult answerResultFinal = new AnswersResult();
//
//      print('inside for ');
//
//      print('correctAnswers_ inside for ${userAnswersList[i].correctAnswers_}');
//
//      print(actualQuestionAndAnswers[i].question);
//
//      if (actualQuestionAndAnswers[i].questionType == "FILL_IN_THE_BLANKS") {
//        answerResultFinal.question = actualQuestionAndAnswers[i].question;
//
//        answerResultFinal.userAnswers = userAnswersList[i].correctAnswers_;
//        answerResultFinal.correctAnswers_=actualQuestionAndAnswers[i].correctAnsower;
//
//        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
//        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;
//
//        if (actualQuestionAndAnswers[i]
//            .correctAnsower[0]
//            .toString()
//            .toLowerCase() ==
//            userAnswersList[i].correctAnswers_[0].toString().toLowerCase()) {
//          answerResultFinal.correctOrNot = true;
////          correctAnswersCount++;
//          answersAfterAllValidations.add(answerResultFinal);
//        } else {
//          answerResultFinal.correctOrNot = false;
//          answersAfterAllValidations.add(answerResultFinal);
//        }
//      } else {
//
//
//        print('not fill in the blanks0');
//
//        print(actualQuestionAndAnswers[i].question);
//        print(actualQuestionAndAnswers[i].correctAnsower);
//        print(userAnswersList[i].correctAnswers_);
//
//
//
//
//        List<String> convertedLowerCaseStrings=[];
//
//
//
//        for(var actualCorrectAnswer in actualQuestionAndAnswers[i].correctAnsower){
//          convertedLowerCaseStrings.add(actualCorrectAnswer.toString().toLowerCase());
//        }
//
//
//
//
//
//        print(deepEq(convertedLowerCaseStrings,
//            userAnswersList[i].correctAnswers_));
//
//
//
//        answerResultFinal.question = actualQuestionAndAnswers[i].question;
//        answerResultFinal.userAnswers = userAnswersList[i].correctAnswers_;
//        answerResultFinal.correctAnswers_=actualQuestionAndAnswers[i].correctAnsower;
//        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
//        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;
//
//
//        if (deepEq(convertedLowerCaseStrings,
//            userAnswersList[i].correctAnswers_) || deepEq(actualQuestionAndAnswers[i].correctAnsower,
//            userAnswersList[i].correctAnswers_) ) {
//
//
//
//
//
//          answerResultFinal.correctOrNot = true;
////          correctAnswersCount++;
//          answersAfterAllValidations.add(answerResultFinal);
//
//
//
//        } else {
//
//
//          answerResultFinal.correctOrNot = false;
//
//          answersAfterAllValidations.add(answerResultFinal);
//
//
//        }
//      }
//    }
//
//    return answersAfterAllValidations;
//  }

  Future getResults() async {
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
//          correctAnswersCount++;
          answersAfterAllValidations.add(answerResultFinal);
        } else if (userAnswersList[i]
            .correctAnswers_[0]
            .toString()
            .toLowerCase() ==
            '') {
//          answersNotAttempted++;
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
          //correctAnswersCount++;
          answersAfterAllValidations.add(answerResultFinal);

          answerResultFinal.isNotAttempted = false;
        } else if (userAnswersList[i]
            .correctAnswers_[0]
            .toString()
            .toLowerCase() ==
            '') {
          print('anil not attempted ${i}');
          //answersNotAttempted++;
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



    for(var i=0;i<userAnswersList.length;i++){

      print('inisde init state ${i}');
      print(userAnswersList[i].correctAnswers_);
      print(userAnswersList[i].questionNumber);
    }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print('inside build of quiz main dart file ');
    print(this.userAnswersList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: FutureBuilder(
          builder: (context, resultSnap) {
            if (resultSnap.hasData) {
              //print('project snapshot data is: ${projectSnap.data}');
              int totalQuestionsLength=resultSnap.data.length;
              return ListView.builder(
                itemCount: resultSnap.data.length,
                itemBuilder: (context, index) {
                  AnswersResult result_current_question = resultSnap.data[index];

                  print('inside listview builder result page ');
//                print('${result_current_question.userAnswers[index]}');

                  return Column(
                    children: <Widget>[
                      Container(



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
//                                result_current_question.correctOrNot ?Text(
////                                    'Correct'
////                                ):
////                                Text(
////                                    'Wrong'
////                                )


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

                      ),
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
}

