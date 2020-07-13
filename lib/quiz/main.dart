import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:comic_poc/model/answoers_result.dart';
import 'package:comic_poc/model/question.dart';
import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:comic_poc/quiz/quizcountdowntimer.dart';
import 'package:comic_poc/quiz/result_page.dart';
import 'package:comic_poc/resource/quizMLPservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

int currentQuestion = 0;
var quiz_submit_UI = null;
List<AnswersResult> answoersList = [];
List<Questionslist_> questionsMap = [];

QuizResponseJson questionResponceInJson;

int comicBookIdGl = 0;

var autoSubmit = false;
int durationOfQuizSpended;
//void main() => runApp(QuizTemplateModelPage());

class QuizTemplateModelPage extends StatelessWidget {
  // This widget is the root of your application.

  // CoursesList comicBook;
  QuizTemplateModelPage() {
    //comicBook = comicBook;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*routes: {
        "/vcomicsDashBoard": (context) => VComicsDashBoardLandingPage(),
      },
      onGenerateRoute: (RouteSettings setting) {
        switch (setting.name) {
          case "/vcomicsDashBoard":
            MaterialPageRoute(
                builder: (context) => VComicsDashBoardLandingPage());
            break;
        }
      },*/
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        //comicBook: comicBook,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //CoursesList comicBook;

  MyHomePage({Key key, this.title, }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //CoursesList comicBook;

  _MyHomePageState();

  static var responce;
  int quizduration;
  var myController = TextEditingController();

  String wrongAnsowerText = '';

  bool isMultipleCheckboxClicked = false;
  //currentQuestion = 0;

  Map<int, Color> btncolor = new HashMap();

  Map<int, Color> pageIndexColors = new HashMap();

  Color colorForSelectedItem = Colors.green;

  var singleCheckboxSelectedOrNot = false;
  var clickedColor;

  var normalTextColor = Colors.black;

  int selectedState;

  String validationEmptyMessage = '';

  Map<String, bool> question_choices = {};

  List<String> user_Answers_arr = [];

  String fillInTheBlankPreviousAnswer = '';

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  int correctAnswersCount;
  int answersNotAttempted;
  List<AnswersResult> answersAfterAllValidations = [];

  bool previousFlag = false;
  @override
  void initState() {
    answoersList = [];
    questionsMap = [];

    questionResponceInJson;
    selectedState = 0;
    // TODO: implement initState

    question_choices = {};
    user_Answers_arr = [];
    getResponce();

    currentQuestion = 0;
  }

  getResponce() {
    this.setState(() {




      /*responce = QuizServices().getComicQuizById(1);*/

      print("inside getQuizJsonDetails");



      responce=QuizMLPServices().getQuizJsonDetails(
          accessToken: 'rwFZT95RfLAAAAAAAAAPFVL8GPJJKlK0MkTqRzG58VxhXCSzoND1l7wP4IkQDz7G',
          quizLocation: '/Comics/Curriculum/Science/Force and Motion/Quiz',
          quizName: 'Force and Motion final Quiz'
      );



      print('responce after service $responce');

      Future<QuizResponseJson> quizData =responce;

      quizData.then((QuizResponseJson questionResponce) => {
        quizduration = questionResponce.quizduration,

        print("Quiz Template Duration $quizduration"),

      });


    });
    setState(() {
      if(quizduration != null)
        timeDurationWidgetUI();
    });
  }
  Widget timeDurationWidgetUI()   {
    print("quizduration $quizduration");
    return  quizduration != null ?  QuizCountDownTimer(quizduration: quizduration,):Text("");
  }

  Future getColors() async {
    if (questionsMap[currentQuestion].questionType == "MULTIPLE_CHOICE") {
      var index = -1;

      if (questionsMap[currentQuestion].choices != null) {
        print('iniside getColors choices');
        questionsMap[currentQuestion].choices.forEach((f) {
          index++;
          var obj = {index: Colors.white};
          btncolor.addAll(obj);
        });

        print(btncolor.length);
      }
    }
  }

  Future<List<AnswersResult>> getResults(
      {List<AnswersResult> userAnswersList,
        List<QuestionAndAnswoers> actualQuestionAndAnswers}) async {
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
            actualQuestionAndAnswers[i].correctAnsower;

        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;

        if (actualQuestionAndAnswers[i]
            .correctAnsower[0]
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
        print(actualQuestionAndAnswers[i].correctAnsower);
        print(userAnswersList[i].correctAnswers_);

        List<String> convertedLowerCaseStrings = [];

        for (var actualCorrectAnswer
        in actualQuestionAndAnswers[i].correctAnsower) {
          convertedLowerCaseStrings
              .add(actualCorrectAnswer.toString().toLowerCase());
        }

        print(deepEq(
            convertedLowerCaseStrings, userAnswersList[i].correctAnswers_));

        answerResultFinal.question = actualQuestionAndAnswers[i].question;
        answerResultFinal.userAnswers = userAnswersList[i].correctAnswers_;
        answerResultFinal.correctAnswers_ =
            actualQuestionAndAnswers[i].correctAnsower;
        answerResultFinal.marks = int.parse(actualQuestionAndAnswers[i].marks);
        answerResultFinal.questionNumber = userAnswersList[i].questionNumber;

        if (deepEq(convertedLowerCaseStrings,
            userAnswersList[i].correctAnswers_) ||
            deepEq(actualQuestionAndAnswers[i].correctAnsower,
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

  int choiceIndexVal_ = 0;

  setSelectedState(int val) {
    setState(() {
      selectedState = val;
    });
  }

  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Quiz Root Page");
    if (questionsMap.length < 0) {
      this.setState(() {
        getResponce();
      });
    }

    var snackBar = SnackBar(
        content: Text('You didn\'t change answer please choose answer !'));
    print(
        'anil flkdflskdfsdkjf $currentQuestion  ------ ${questionsMap.length - 1}');

    quiz_submit_UI = MaterialButton(
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0),
        child: Text(
          'Submit',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      onPressed: () {
        print('inside onPressed of $currentQuestion');

//              for(var i=0;i<_tabController.length)

        if (singleCheckboxSelectedOrNot ||
            myController.text != '' ||
            autoSubmit == true) {
          _scaffoldKey.currentState.hideCurrentSnackBar();

          answerValidations(currentQuestion_: currentQuestion);

          fillInTheBlankPreviousAnswer = '';
          previousFlag = false;

          /*Future<List<AnswersResult>> futureResults = getResults(
              userAnswersList: answoersList,
              actualQuestionAndAnswers: questionsMap);
          futureResults.then((data) {
            List<AnswersResult> answersResults = data.toList();
            prefs.then((userData) async {
              String userId = userData.getString("uid");
              final snapShot = await Firestore.instance
                  .collection('commic_users')
                  .document(userId)
                  .collection('quiz_dashboard')
                  .document(comicBookId.toString())
                  .setData({
                'quizName': questionResponceInJson.quizName,
                'quizId': questionResponceInJson.quizId,
                'correct_answers': correctAnswersCount,
                'not_attempted_answers': answersNotAttempted,
                'totalQuestions': questionResponceInJson.questionslist.length,
                'view_solutions_json': jsonEncode(answersResults)
              });
            });
          });*/

          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => ResultPage(
              userAnswersList: answoersList,
              actualQuestionAndAnswers: questionsMap,


              durationOfQuizSpended: durationOfQuizSpended,
            ),
          );
          Navigator.pushReplacement(context, route);
        } else {
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      },
    );

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
//        resizeToAvoidBottomPadding: false,
//        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              //TimerUI(),
              FutureBuilder<QuizResponseJson>(
                future: responce,
                builder: (BuildContext context, AsyncSnapshot<QuizResponseJson> snapshot){
                  if(snapshot.hasData){

                    return QuizCountDownTimer(quizduration: snapshot.data.quizduration,);
                  }else{
                    return Text("");
                  }
                },
              ),
              //quizduration!=null ?QuizCountDownTimer(quizduration: quizduration,):Text(""),
              Container(
//              color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Quiz',

                    textAlign: TextAlign.right,
                  ),
                ),





                // padding: EdgeInsets.only(left:30),
//            padding: EdgeInsets.only(top:50),
                // height: MediaQuery.of(context).size.height*0.4,
//              child: Column(
//                children: <Widget>[
////                  Text('Quiz',
////                  style: title_text_style,)
//                  Row(
//                    children: <Widget>[
//                      Icon(
//                        Icons.pause_circle_outline,
//                        color: Colors.orange,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Text(
//                          '12.30',
//                          style: TextStyle(
//                              color: Colors.black, fontWeight: FontWeight.bold),
//                        ),
//                      )
//                    ],
//                  ),
//                ],
//              ),
              ),
            ],
          ),
          actions: <Widget>[
            quiz_submit_UI,
          ],
        ),
        bottomNavigationBar: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentQuestion != 0
                ? Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: MaterialButton(
                /*shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),*/
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.orange,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Previous',
                        style:
                        TextStyle(color: Colors.orange, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                // color: Colors.blue,
                onPressed: () {
//                      goToPreviousPage();

                  previousFlag = true;
                  fillInTheBlankPreviousAnswer = '';

                  if (currentQuestion > 0) {
                    currentQuestion--;
                    getPreviousUserAnswer(
                        context: context,
                        currentQuestion_: currentQuestion);
                  }

//                  _tabController.animateTo(currentQuestion);
                },
              ),
            )
                : Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Text(''),
            ),
            currentQuestion < questionsMap.length - 1 ||
                questionsMap.length == 0
                ? Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: MaterialButton(
                /*shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),*/

                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        'Next',
                        style:
                        TextStyle(color: Colors.orange, fontSize: 15),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.orange,
                    ),
                  ],
                ),
                // color: Colors.blue,
                onPressed: () {
//                goToNextPage();

                  print(
                      'singleCheckboxSelectedOrNot ===> ${singleCheckboxSelectedOrNot} ------ ${myController.text == ''}');

                  answerValidations(currentQuestion_: currentQuestion);

                  if (currentQuestion < questionsMap.length - 1) {
                    print('inside if ${currentQuestion}');
                    currentQuestion++;

                    getPreviousUserAnswer(
                        context: context,
                        currentQuestion_: currentQuestion);

                    singleCheckboxSelectedOrNot = false;
                  }

                  fillInTheBlankPreviousAnswer = '';
                  previousFlag = false;
                },
              ),
            )
                : Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Text(''),
            ),
          ],
        ),
        body: FutureBuilder<QuizResponseJson>(
          future: responce, // a previously-obtained Future<String> or null
          builder:
              (BuildContext context, AsyncSnapshot<QuizResponseJson> snapshot) {
            if (snapshot.hasData) {
              questionResponceInJson = snapshot.data;

              print(
                  'questionResponceInJson  ${questionResponceInJson.questionslist.length}');

              questionsMap = questionResponceInJson.questionslist;
//              fo{
////
////              }

              if (answoersList.length < questionsMap.length) {
                for (var i = 0; i < questionsMap.length; i++) {
                  var color;
                  if (i == 0) {
                    color = {i: Colors.blue};
                  } else {
                    color = {i: Colors.white};
                  }

                  pageIndexColors.addAll(color);

                  AnswersResult currentQuestionResult = new AnswersResult();
                  List<String> user_answers_list = [];

                  user_answers_list.add('');
                  currentQuestionResult.correctAnswers_ = user_answers_list;
                  currentQuestionResult.questionNumber = i;
                  currentQuestionResult.question = questionsMap[i].question;
                  currentQuestionResult.marks =
                      int.parse(questionsMap[i].marks);

                  answoersList.insert(i, currentQuestionResult);
                }

                print('after 00000 for');

                print(answoersList.length);
                print(questionsMap.length);
              }

//            getColors();

              if (currentQuestion < questionsMap.length &&
                  questionsMap[currentQuestion].choices != null &&
                  btncolor.length !=
                      questionsMap[currentQuestion].choices.length) {
//                setState(() {

                if (!previousFlag) {
                  getColors();
                }

//                });

              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              for (var item in questionsMap)
                                Material(
                                  color: pageIndexColors[
                                  questionsMap.indexOf(item)],
                                  borderRadius: new BorderRadius.circular(18.0),
                                  child: InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                          (questionsMap.indexOf(item) + 1)
                                              .toString()),
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        FocusScope.of(context).unfocus();
                                        pageIndexColors.forEach((k, v) {
                                          print('${k}: ${v}');

                                          if (k == questionsMap.indexOf(item)) {
                                            pageIndexColors[k] = Colors.blue;
                                          } else {
                                            pageIndexColors[k] =
                                                Colors.transparent;
                                          }
                                        });
                                      });

                                      print(
                                          'questionsMap.indexOf(item) ${questionsMap.indexOf(item)}');
//
//                                  setState(() {
//                                    currentQuestion =
//                                        questionsMap.indexOf(item);
//                                  });

                                      print(
                                          'singleCheckboxSelectedOrNot ===> ${singleCheckboxSelectedOrNot} ------ ${myController.text == ''}');

                                      /*  if (singleCheckboxSelectedOrNot || myController.text != '') {
                    _scaffoldKey.currentState.hideCurrentSnackBar();*/

//
//                                  previousFlag = false;
//                                  currentQuestion = ;
//

                                      answerValidations(
                                          currentQuestion_: currentQuestion);

                                      fillInTheBlankPreviousAnswer = '';

                                      previousFlag = true;
                                      singleCheckboxSelectedOrNot = false;

                                      getPreviousUserAnswer(
                                          context: context,
                                          currentQuestion_:
                                          questionsMap.indexOf(item));
                                    },
                                  ),
                                ),
                            ]),
                      )),
                  Container(
                      child: currentQuestion < questionsMap.length
                          ? questionsMap[currentQuestion].questionType ==
                          "FILL_IN_THE_BLANKS"
                          ? Container(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Center(
                                child:
                                fill_in_the_blanks_fun(context)),
                          ),
                        ),
                      )
                          : questionsMap[currentQuestion].questionType ==
                          "MULTIPLE_CHOICE"
                          ? multipleChoices(context)
                          : questionsMap[currentQuestion]
                          .questionType ==
                          "MULTI_CORRECT"
                          ? checkBoxWidjectUI(
                          questionObj:
                          questionsMap[currentQuestion],
                          questionNum: currentQuestion,
                          context: context)
                          : questionsMap[currentQuestion]
                          .questionType ==
                          "TRUE_OR_FALSE"
                          ? trueOrFalseUI(context)
                          : Container()
                          : Container(
                        child: Center(
                          child: Text(
                            "No More Questions",
                          ),
                        ),
                      )
                    // This trailing comma makes auto-formatting nicer for build methods.
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'Awaiting result...',
                ),
              );
            }
          },
        ));
  }

  answerValidations({dynamic currentQuestion_}) {
    print('answerValidations answerValidations');
    print(answoersList.length);

//    print();
//    var startRange=currentQuestion-1;
//    var userAnswers=answoersList.getRange(startRange, currentQuestion);
//userAnswers.forEach((f){
//  print('usersAnswers ${f.correctAnswers_}');
//});
    if (questionsMap[currentQuestion_].questionType == "FILL_IN_THE_BLANKS") {
      print('FILL_IN_THE_BLANKS --------------> ${myController.text}');

      ansowerValidationFunForFillInTheBlanks(
          userAnsower: myController.text,
          context: context,
          currentQuestion_: currentQuestion_);
    } else if (questionsMap[currentQuestion_].questionType ==
        "MULTIPLE_CHOICE") {
      ansowerValidationFunForFillInTheBlanks(
          userAnsower: questionsMap[currentQuestion_].choices[choiceIndexVal_],
          choiceIndex: choiceIndexVal_,
          currentQuestion_: currentQuestion_,
          context: context);
    } else if (questionsMap[currentQuestion_].questionType == "TRUE_OR_FALSE") {
      ansowerValidationFunForFillInTheBlanks(
          context: context,
          currentQuestion_: currentQuestion_,
          userAnsower: selectedState > 0
              ? questionsMap[currentQuestion_].choices[selectedState - 1]
              : '');
    } else if (questionsMap[currentQuestion_].questionType == "MULTI_CORRECT") {
      question_choices.forEach((key, value) {
        if (value == true) {
          user_Answers_arr.add(key);
        }
      });
      print('inside getCheckBox Items ${user_Answers_arr.length}');
      ansowerValidationFunForFillInTheBlanks(
          user_ansewers_: user_Answers_arr,
          context: context,
          currentQuestion_: currentQuestion_);
//                    getCheckboxItems(user_Answers_arr,questionsMap[currentQuestion] , currentQuestion);
    }
  }

  getPreviousUserAnswer({BuildContext context, dynamic currentQuestion_}) {
    setState(() {
      currentQuestion = currentQuestion_;

      pageIndexColors.forEach((k, v) {
        print('${k}: ${v}');

        if (k == currentQuestion) {
          pageIndexColors[k] = Colors.blue;
        } else {
          pageIndexColors[k] = Colors.transparent;
        }
      });

//        currentQuestion--;

      print(
          'inside previous onpressed ${answoersList[currentQuestion].correctAnswers_[0]}');
      print(answoersList[currentQuestion].correctAnswers_[0]);

      if (questionsMap[currentQuestion].questionType == "FILL_IN_THE_BLANKS") {
        fillInTheBlankPreviousAnswer =
        answoersList[currentQuestion].correctAnswers_[0];
      } else if (questionsMap[currentQuestion].questionType ==
          "MULTIPLE_CHOICE") {
        var answer = answoersList[currentQuestion].correctAnswers_[0];

        print(answer);
        if (currentQuestion < questionsMap.length &&
            questionsMap[currentQuestion].choices != null) {
          var index = -1;

          if (questionsMap[currentQuestion].choices != null) {
            print('iniside getColors choices');
            questionsMap[currentQuestion].choices.forEach((f) {
              index++;
              var obj;

              print('f is $f');

              if (f.toLowerCase() == answer) {
                obj = {index: Colors.blue};
              } else {
                obj = {index: Colors.white};
              }

              btncolor.addAll(obj);
            });

            print(btncolor.length);
          }
        }
      } else if (questionsMap[currentQuestion].questionType == "MULTI_CORRECT") {
        print('inside checkbox');

        if (question_choices.length == 0) {
          question_choices = Map.fromIterable(
              questionsMap[currentQuestion].choices,
              key: (e) => e,
              value: (e) =>
              answoersList[currentQuestion_].correctAnswers_.contains(e)
                  ? true
                  : false);
        }
      } else if (questionsMap[currentQuestion].questionType ==
          "TRUE_OR_FALSE") {}

//                        answoersList.removeAt(currentQuestion);
    });
  }

  Widget trueOrFalseUI(BuildContext context) {
    print(' tureOrFalse UI ');

    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  color: Color(0xff0e67c2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(questionsMap[currentQuestion].question,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    questionsMap[currentQuestion].choices.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Radio(
                            groupValue: selectedState,
                            value: index + 1,
                            onChanged: (val) {
                              singleCheckboxSelectedOrNot = true;
                              print('val is ${val}');
                              setSelectedState(val);
                            },
                          ),
                        ),
                        Text(
                          questionsMap[currentQuestion].choices[index].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );

                  Text(questionsMap[currentQuestion].choices[index].toString());
                }),
              ),
            )
          ],
        ));
//      ),
//    );
  }

  List<String> user_answers_list = [];
  Widget multipleChoices(BuildContext context) {


    print("multipleChoices ${questionsMap[currentQuestion].question}");


    return Container(
//      color: Color(0xfff0f1f7),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
//            padding: EdgeInsets.all(20),
//              color: Color(0xff0e67c2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        (currentQuestion + 1).toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        questionsMap[currentQuestion].question,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(18),
                  itemCount: questionsMap[currentQuestion].choices.length,
//                            shrinkWrap:false,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0)),
                              elevation: 18.0,
                              color: Color(0xFFfcfcfc),
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                color: btncolor[index],
                                child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      questionsMap[currentQuestion]
                                          .choices[index],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  singleCheckboxSelectedOrNot = true;

                                  choiceIndexVal_ = index;

                                  setState(() {
                                    btncolor.forEach((k, v) {
                                      print('${k}: ${v}');

                                      if (k == index) {
                                        btncolor[k] = Colors.blue;
                                      } else {
                                        btncolor[k] = Colors.white;
                                      }
                                    });
                                  });
                                },
                              ),
                            ),
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
//          Text(
//            wrongAnsowerText,
//            style: TextStyle(color: Colors.red,fontSize:20),
//
//          )
        ],
      ),
    );
  }

  Column fill_in_the_blanks_fun(BuildContext context) {
//print(user_answers_list[currentQuestion]);

    print(fillInTheBlankPreviousAnswer);

    myController.text = fillInTheBlankPreviousAnswer;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              child: Text(
                (currentQuestion + 1).toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                questionsMap[currentQuestion].question,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: 300,
            child: TextField(
              controller: myController,
              decoration: new InputDecoration(
                labelText: "Enter Your Answer",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              keyboardType: TextInputType.emailAddress,
              style: new TextStyle(
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
        Text(
          wrongAnsowerText,
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  ansowerValidationFunForFillInTheBlanks(
      {String userAnsower,
        int choiceIndex,
        BuildContext context,
        List<String> user_ansewers_,
        dynamic currentQuestion_}) {
    user_answers_list = [];

    AnswersResult currentQuestionResult = new AnswersResult();
    currentQuestionResult.correctAnswers_ = user_answers_list;
    currentQuestionResult.questionNumber = currentQuestion_;
    currentQuestionResult.question = questionsMap[currentQuestion_].question;
    currentQuestionResult.marks =
        int.parse(questionsMap[currentQuestion_].marks);

    if (questionsMap[currentQuestion_].questionType == "MULTIPLE_CHOICE" ||
        questionsMap[currentQuestion_].questionType == "TRUE_OR_FALSE") {
      singleCheckboxSelectedOrNot
          ? user_answers_list.add(userAnsower.toLowerCase())
          : user_answers_list.add('');
    } else if (questionsMap[currentQuestion_].questionType ==
        "FILL_IN_THE_BLANKS") {
      print('inside answoersList validations Next');
      print('dfsdfsdfdf ${userAnsower.toLowerCase()}');

      user_answers_list.add(userAnsower.toLowerCase());
    }

    if (questionsMap[currentQuestion_].questionType == "MULTI_CORRECT") {
      print(
          ' inside answers validation     ----> $user_ansewers_ ${user_ansewers_}');

      if (user_ansewers_.length > 0) {
        for (var answer in user_ansewers_) {
          print('valid for valuse in ${answer}');
          user_answers_list.add(answer);
        }

//        user_answers_list = user_ansewers_;
      } else {
        user_answers_list.add('');
      }
    }

    answoersList.removeAt(currentQuestion_);

    answoersList.insert(currentQuestion_, currentQuestionResult);

    if (currentQuestion_ < questionsMap.length) {
      this.setState(() {
//      if (questionsMap[currentQuestion].correctAnsower[0].toLowerCase() ==
//          userAnsower.toLowerCase()) {

        if (questionsMap[currentQuestion_].questionType == "MULTIPLE_CHOICE") {
          btncolor.forEach((k, v) {
            print('${k}: ${v}');

            btncolor[k] = Colors.white;
          });
        } else {
          user_Answers_arr.clear();
        }

        print('answoersList.length ********* ${answoersList.length}');
        //}
      });
    } else {
      print('answoersList else ${answoersList}');
      print('answoersList else ${answoersList.length}');

      for (var answer in answoersList) {
        print(answer.correctAnswers_);
      }
    }
  }

  Widget checkBoxWidjectUI(
      {Questionslist_ questionObj,
        int questionNum,
        BuildContext context}) {
    print("inside checkBoxWidjectUI");
    if (!previousFlag) {
      if (question_choices.length == 0) {
        question_choices = Map.fromIterable(questionObj.choices,
            key: (e) => e, value: (e) => false);
      }
    }

    return Container(
      padding: EdgeInsets.all(15.0),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(children: <Widget>[
        Expanded(
          flex: 0,
          child: Container(
//            padding: EdgeInsets.only(left: 10),
//            color: Color(0xff0e67c2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text(
                    (questionNum + 1).toString(),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                      questionObj.question ,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: question_choices.keys.map((String key) {
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: new CheckboxListTile(
                    value: question_choices[key],
                    title: new Text(key),
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    onChanged: (bool value) {
                      print(value);
                      singleCheckboxSelectedOrNot = true;
                      this.setState(() {
                        question_choices[key] = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ]),
    );
  }

  getCheckboxItems(user_Answers_arr, questionObj, questionNum) {
    print(answoersList);

    question_choices.forEach((key, value) {
      if (value == true) {
        user_Answers_arr.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print('user choice answers ${user_Answers_arr}');
    // Here you will get all your selected Checkbox items.

    //  validateAnswer(user_Answers_arr, questionObj, questionNum);
    ansowerValidationFunForFillInTheBlanks(user_ansewers_: user_Answers_arr);
    // Clear array after use.
  }

  validateAnswer(userAnswers, questionObj, questionNum) {}
}
