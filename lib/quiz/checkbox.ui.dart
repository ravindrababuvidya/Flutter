import 'package:comic_poc/model/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:collection/collection.dart';


class CheckboxWidget extends StatefulWidget {
  QuestionAndAnswoers questionObj;
  int questionNum;
  CheckboxWidget({this.questionObj, this.questionNum});

  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState(
      questionObj: questionObj, questionNum: questionNum);
}

class CheckboxWidgetState extends State {
  QuestionAndAnswoers questionObj;

  int questionNum;
  CheckboxWidgetState({this.questionObj, this.questionNum});

  Map<String, bool> question_choices = {};

  List<String> user_Answers_arr = [];

  getCheckboxItems() {
    question_choices.forEach((key, value) {
      if (value == true) {
        user_Answers_arr.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(user_Answers_arr);
    // Here you will get all your selected Checkbox items.

    validateAnswer(user_Answers_arr);

    // Clear array after use.

  }
  validateAnswer(userAnswers){


    Function deepEq = const DeepCollectionEquality().equals;

    print(deepEq(user_Answers_arr,questionObj.correctAnsower));

    user_Answers_arr.clear();
  }
  @override
  void initState() {
    // TODO: implement initState
    question_choices = Map.fromIterable(questionObj.choices, key: (e) => e, value: (e) => false);
    print(question_choices);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
//      RaisedButton(
//        child: Text(
//          " Get Selected Checkbox Items ",
//          style: TextStyle(fontSize: 18),
//        ),
//        onPressed: getCheckboxItems,
//        color: Colors.deepOrange,
//        textColor: Colors.white,
//        splashColor: Colors.grey,
//        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//      ),
      Expanded(
        flex: 1,
        child: ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            padding: EdgeInsets.only(left: 10),
            color: Color(0xff0e67c2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.075,
                  child: Text(
                    (questionNum + 1).toString() + ' . ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Text(questionObj.question,
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
      Expanded(
        flex: 3,
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
                    setState(() {
                      question_choices[key] = value;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              onPressed: () {

                getCheckboxItems();


              },

              child: const Text('Submit', style: TextStyle(fontSize: 20)),
              color: Colors.blue,
              textColor: Colors.white,
              elevation: 5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {

                  AlertDialog alert = AlertDialog(
                      title: Text("VCOMIC"),
                  content: Text("Feature coming soon "),
                  );

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );

                },
                child: const Text('Skip', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          )
        ],
      )

    ]);
  }
}





