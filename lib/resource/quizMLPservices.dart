import 'dart:convert';


import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:http/http.dart' as http;

class QuizMLPServices{
  final String VCOMICS_API_URL = "https://192.168.15.73:8443/ModernLearningPlatform/api/v1";
  Future<QuizResponseJson> getQuizJsonDetails({String quizName,String accessToken,String quizLocation}) async {

    print('${VCOMICS_API_URL}/getTestAndQuizzes?quizURL=$quizLocation&accessToken=$accessToken&quizName=$quizName');
    http.Response response = await http.get(
        '${VCOMICS_API_URL}/getTestAndQuizzes?quizURL=$quizLocation&accessToken=$accessToken&quizName=$quizName');

    print(response.statusCode);
    if(response.statusCode == 200){
      return QuizResponseJson.fromJson(json.decode(response.body));
    }else {
      print("inside statusCode error else");
      throw("Something went wrong");
    }



  }
}