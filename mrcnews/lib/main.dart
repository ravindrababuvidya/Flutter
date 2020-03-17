import 'package:flutter/material.dart';
import 'package:mrcnews/src/view/NewsHomeRootPage.dart';
import 'package:mrcnews/src/view/assement_multiplechoice.dart';
import 'package:mrcnews/src/view/errorpage.dart';
import 'package:mrcnews/src/view/news_web_view.dart';

void main()=> runApp(NewsRootPage());

class NewsRootPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        "/home":(context)=> NewsHomeRootPage(),
        "/newswebview":(context)=>NewsWebView(),
        "/multiple":(context)=>MultipleChoiceLayout(),

      },
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name){
          case '/newswebview':
            print("This method called");
            String web_URL = settings.arguments;
            MaterialPageRoute(builder: (context)=>NewsWebView(url: web_URL,));
            break;
          case "/home":
            MaterialPageRoute(builder: (context)=>NewsHomeRootPage());
            break;
          case "/multiple":
            MaterialPageRoute(builder: (context)=>MultipleChoiceLayout());
            break;


        }

      },
      onUnknownRoute: (RouteSettings settings){
       return  MaterialPageRoute(builder: (context)=>ErrorPage());

      },
    );
    throw UnimplementedError();
  }
}