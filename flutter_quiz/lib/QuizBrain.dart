import 'package:flutter_quiz/Question.dart';
int questionNumber =0;
class QuizBrain{
  List<Question> _questionBank =[
    Question(q:"As far as has ever been reported, no-one has ever seen an ostrich bury its head in the sand.",a:true),
    Question(q:"Approximately one quarter of human bones are in the feet.",a:true),
    Question(q:"Popeye’s nephews were called Peepeye, Poopeye, Pipeye and Pupeye.",a:true),
    Question(q:"In ancient Rome, a special room called a vomitorium was available for diners to purge food in during meals.",a:false),
    Question(q:"The average person will shed 10 pounds of skin during their lifetime.",a:false),
    Question(q:"Sneezes regularly exceed 100 m.p.h.",a:true),
    Question(q:"A slug’s blood is green.",a:false),
    Question(q:"The Great Wall Of China is visible from the moon.",a:true),
    Question(q:"Virtually all Las Vegas gambling casinos ensure that they have no clocks.",a:true),
    Question(q:" The total surface area of two human lungs have a surface area of approximately 70 square metres.",a:true),

  ];
  int getQuestionCounterNumber(){
    if(questionNumber < _questionBank.length - 1){
      questionNumber++;
    }else{
      questionNumber =0;
    }
    print("questionNumber$questionNumber");
    print(_questionBank.length);
    return questionNumber;
  }
  String getQuestionText(){
    return _questionBank[questionNumber].questionText;
  }
  bool getQuestionAnswer(){
    return _questionBank[questionNumber].questionAnswer;
  }
}