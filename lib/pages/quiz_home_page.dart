import 'package:comic_poc/quiz/main.dart';
import 'package:flutter/material.dart';

class QuizHomePage extends StatelessWidget{
  String title;
  QuizHomePage({this.title});
  @override
  Widget build(BuildContext context) {
    return QuizHomeMain(title: title,);
  }
}

class QuizHomeMain extends StatefulWidget{
  String title;
  QuizHomeMain({this.title});
  @override
  _QuizHomeMainState createState() => _QuizHomeMainState();
}

class _QuizHomeMainState extends State<QuizHomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Quiz'),
      ),
      body: QuizTemplateModelPage(),
    );
  }
}