import 'package:comic_poc/data/topic_data.dart';
import 'package:comic_poc/model/topic_model.dart';
import 'package:comic_poc/pages/comic_image_reader_page.dart';
import 'package:comic_poc/pages/quiz_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicsHomePage extends StatefulWidget{
  final String title;
  TopicsHomePage({this.title});
  @override
  _TopicsHomePageState createState() => _TopicsHomePageState();
}

class _TopicsHomePageState extends State<TopicsHomePage> {
  List<TopicsData> topicsListData =[];

  @override
  void initState() {
    topicData.forEach((element) {
      element.forEach((key, value) {
        print(value);
      });
      topicsListData.add(TopicsData.fromJson(element));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemBuilder: (context,index){
            return Container(
              /*child: Row(
                children: <Widget>[
                  Text(topicsListData[index].courseId),
                  Text(topicsListData[index].topicName),
                ]
              ),*/
              child: InkWell(
                child: ListTile(
                  leading: Text(topicsListData[index].courseId),
                  title: Text(topicsListData[index].topicName),
                  subtitle: Text(topicsListData[index].topicName),
                ),
                onTap: (){
                  String title =topicsListData[index].topicName;
                  if(topicsListData[index].topicHavePrequiresmentTestAvailablity){
                    var route = MaterialPageRoute(
                      builder: (context)=> QuizHomePage(title: title,),
                    );
                    Navigator.push(context, route);
                    /*showModalBottomSheet(context: context, builder: (context){
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(title),
                        ),
                      );
                    });*/
                  }else{
                    print("Data No quiz");
                    var route = MaterialPageRoute(
                      builder: (context)=> ComicReaderImagePage(title: title,),
                    );
                    Navigator.push(context, route);

                  }

                },
              ),
            );
          },
        itemCount: topicsListData.length,
      ),
    );
  }
}