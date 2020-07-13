/*
class QuizResponseJson {
  int quizduration;
  String quizName;
  String quizId;
  List<Questionslist> questionslist;

  QuizResponseJson(
      {this.quizduration, this.quizName, this.quizId, this.questionslist});

  QuizResponseJson.fromJson(Map<String, dynamic> json) {
    quizduration = json['quizduration'];
    quizName = json['quizName'];
    quizId = json['quizId'];
    if (json['questionslist'] != null) {
      questionslist = new List<Questionslist>();
      json['questionslist'].forEach((v) {
        questionslist.add(new Questionslist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizduration'] = this.quizduration;
    data['quizName'] = this.quizName;
    data['quizId'] = this.quizId;
    if (this.questionslist != null) {
      data['questionslist'] =
          this.questionslist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questionslist {
  String questionType;
  String question;
  List<String> correctAnswer;
  String marks;
  List<String> choices;

  Questionslist(
      {this.questionType,
        this.question,
        this.correctAnswer,
        this.marks,
        this.choices});

  Questionslist.fromJson(Map<String, dynamic> json) {
    questionType = json['questionType'];
    question = json['question'];
    correctAnswer = json['correct_answer'].cast<String>();
    marks = json['marks'];
    choices = json['choices'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionType'] = this.questionType;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['marks'] = this.marks;
    data['choices'] = this.choices;
    return data;
  }
}*/
class QuizResponseJson {
  int quizduration;
  String quizName;
  List<Questionslist_> questionslist;

  QuizResponseJson({this.quizduration, this.quizName, this.questionslist});

  QuizResponseJson.fromJson(Map<String, dynamic> json) {
    quizduration = json['quizduration'];
    quizName = json['quizName'];
    if (json['questionslist'] != null) {
      questionslist = new List<Questionslist_>();
      json['questionslist'].forEach((v) {
        questionslist.add(new Questionslist_.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizduration'] = this.quizduration;
    data['quizName'] = this.quizName;
    if (this.questionslist != null) {
      data['questionslist'] =
          this.questionslist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questionslist_ {
  String questionType;
  String question;
  List<String> correctAnswer;
  String marks;
  List<String> choices;
  String success;

  Questionslist_(
      {this.questionType,
        this.question,
        this.correctAnswer,
        this.marks,
        this.choices,
      this.success});

  Questionslist_.fromJson(Map<String, dynamic> json) {
    questionType = json['questionType'];
    question = json['question'];
    correctAnswer = json['correct_answer'].cast<String>();
    marks = json['marks'];
    choices = json['choices'].cast<String>();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionType'] = this.questionType;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['marks'] = this.marks;
    data['choices'] = this.choices;
    data['success'] = this.success;
    return data;
  }
}

/*
class Questionslist_ {
  String questionType;
  String question;
  List<String> correctAnswer;
  String marks;
  List<String> choices;
  String success;

  Questionslist_(
      {this.questionType,
        this.question,
        this.correctAnswer,
        this.marks,
        this.choices,
        this.success});

  Questionslist_.fromJson(Map<String, dynamic> json) {
    questionType = json['questionType'];
    question = json['question'];
    correctAnswer = json['correct_answer'].cast<String>();
    marks = json['marks'];
    choices = json['choices'].cast<String>();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionType'] = this.questionType;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['marks'] = this.marks;
    data['choices'] = this.choices;
    data['success'] = this.success;
    return data;
  }
}*/
