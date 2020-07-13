class QuestionAndAnswoers {
  String questionType;
  String question;
  List<dynamic> correctAnsower;
  String marks;
  List<String> choices;
  String imageLink;

  QuestionAndAnswoers(
      {this.questionType,
        this.question,
        this.correctAnsower,
        this.marks,
        this.choices,
      this.imageLink});

  QuestionAndAnswoers.fromJson(Map<String, dynamic> json) {
    questionType = json['questionType'];
    question = json['question'];
    correctAnsower  = json['correct_ansower'];



    marks = json['marks'];
    choices =json['choices'] !=null ? json['choices'].cast<String>():null;
    imageLink=json['imageLink'] !=null ? json['imageLink']:null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionType'] = this.questionType;
    data['question'] = this.question;
    data['correct_ansower'] = this.correctAnsower;
    data['marks'] = this.marks;
    data['choices'] = this.choices ;
    return data;
  }
}

