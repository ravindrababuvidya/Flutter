import 'package:comic_poc/data/comic_images_data.dart';
import 'package:comic_poc/model/comic_images_model.dart';
import 'package:comic_poc/pages/quiz_home_page.dart';
import 'package:comic_poc/pages/quiz_template_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComicReaderImagePage extends StatefulWidget{
  String title;
  ComicReaderImagePage({this.title});
  @override
  _ComicReaderImagePageState createState() => _ComicReaderImagePageState();
}

class _ComicReaderImagePageState extends State<ComicReaderImagePage> {
  List<ComicImages> comicImagesList = [];
  PageController _scrollController;
  @override
  void initState() {
    comicImagesListData.forEach((element) {
      comicImagesList.add(ComicImages.fromJson(element));
    });
    _scrollController = PageController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView.builder(
        controller: _scrollController,
        itemBuilder: (context,index){
          return Container(
            child: Image.network(
              comicImagesList[index].topicImageUrl,
            ),
          );
        },
        itemCount: comicImagesList.length,
        onPageChanged: (value){
          if(comicImagesList[value].quizIsAvailbleInPage){
            var route = MaterialPageRoute(
              builder: (context)=> QuizDummyTemplate(title: widget.title,),
            );
            Navigator.push(context, route);
          }
          print("Value $value");
        },
      ),
    );
  }
}