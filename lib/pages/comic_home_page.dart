import 'dart:convert';
import 'dart:math';

import 'package:comic_poc/data/comic_data.dart';
import 'package:comic_poc/model/comic_model.dart';
import 'package:comic_poc/pages/topic_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicHomePage extends StatefulWidget {
  @override
  _ComicHomePageState createState() => _ComicHomePageState();
}

class _ComicHomePageState extends State<ComicHomePage>
    with SingleTickerProviderStateMixin {
  List<ComicData> comicsData = [];
  AnimationController _controller;
  Animation _animation;
  Colors _colors;
  List colors = [Colors.red, Colors.green, Colors.yellow,Colors.purple,Colors.cyan];
  Random random = new Random();
  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(5));
  }
  @override
  void initState() {
    print("@@@@@@ comicencode.length ${comicsListData.length}");
    comicsListData.forEach((element) {
      comicsData.add(ComicData.fromJson(element));
    });
    _controller = AnimationController(
      vsync: this,
      //animationBehavior: AnimationBehavior.normal,
      duration: Duration(seconds: 2),
    )..repeat();
    _controller.addListener(() {
      print("Calling");
      setState(() {
        changeIndex();
        //_colors = colors[index];
      });
    });
    /*_animation = Tween(begin: 0.0,end: 1.0).animate(_controller)
    ..addStatusListener((status) {
      if(status == AnimationStatus.forward){
        _controller.reverse(from: 1.0);
        print("forward");
      }else if(status == AnimationStatus.completed){
      _controller.forward(from: 0.0);
      print("completed");
      }else if(status == AnimationStatus.reverse){
      _controller.forward(from: 0.0);
      print("reverse");
      }else if(status == AnimationStatus.dismissed){
        _controller.reverse(from: 1.0);
        print("dismissed");
      }
    });
    _controller.addListener(() {
      setState(() {

      });
    });
    _controller..forward(from: 0.0);*/
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vcomic App"),
          actions: <Widget>[
            Container(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * pi,
                    child: child,
                  );
                },
                child: IconButton(
                  icon: Icon(Icons.star,color: colors[index],),
                ),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: comicsData.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Image.network(
                          comicsData[index].courseTemporaryThumbnailURL,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Text(comicsData[index].courseName)),
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Text(comicsData[index].description)),
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Text(comicsData[index].author)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: (){
                var route = MaterialPageRoute(
                  builder: (context)=>TopicsHomePage(title: comicsData[index].courseName,),
                );
                Navigator.push(context, route);
              },
            );
          },
        ));
  }
}
