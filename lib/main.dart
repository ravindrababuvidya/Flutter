import 'dart:io';

import 'package:comic_poc/data/quiz_data.dart';
import 'package:comic_poc/global/http_header.dart';
import 'package:comic_poc/model/quiz_model_data.dart';
import 'package:comic_poc/pages/comic_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => {
  HttpOverrides.global = new MyHttpOverrides(),
  runApp(
    //Navigator.pushReplacement(context, newRoute)
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ComicHomePage(),
       // home: QuizDummyTemplate(),
      )
  ),
};



