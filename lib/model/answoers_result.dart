import 'dart:convert';
class AnswersResult{

  int questionNumber;
  String question;
  List<dynamic>  correctAnswers_;
  int marks;
  bool correctOrNot;
  bool isNotAttempted;
  List<dynamic> userAnswers;

  AnswersResult({this.correctAnswers_,this.question,this.questionNumber,this.correctOrNot,this.userAnswers,this.isNotAttempted});

//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.questionslist != null) {
//      data['questionslist'] =
//          this.questionslist.map((v) => v.toJson()).toList();
//    }
//    data['quizId'] = this.quizId;
//    data['quizName'] = this.quizName;
//    return data;
//  }


  Map toJson() => {
    'questionNumber': questionNumber,
    'question': question,
    'marks':marks,
    'correctOrNot':correctOrNot,
    'is_not_attempted':isNotAttempted,
    'userAnswers':jsonEncode(userAnswers),
    'correctAnswers':jsonEncode(correctAnswers_)
  };





}