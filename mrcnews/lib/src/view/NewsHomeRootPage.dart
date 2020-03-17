
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mrcnews/src/global_constans/ui/globalTextStyle.dart';
import 'package:mrcnews/src/model/article.dart';
import 'package:mrcnews/src/repository/newsApiHttpClient.dart';
import 'package:mrcnews/src/view/fillIntheblankPOc.dart';
import 'package:mrcnews/src/view/setting_page.dart';
import 'package:mrcnews/src/view/user_details.dart';

class NewsHomeRootPage extends StatefulWidget{
  _NewsHomeRootPageState createState()=> _NewsHomeRootPageState();
}

class _NewsHomeRootPageState extends State<NewsHomeRootPage> with SingleTickerProviderStateMixin{
  AnimationController _controller ;
  Animation _animation ;
  bool isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ).drive(Tween(begin: 0,end: 1));
  }
  void updateBottomActive(){
    print(isActive);
    setState(() {
      if(isActive){
        isActive = false;
      }else{
        isActive = true;
      }

    });
  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }


@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          title: Text("MRC NEWS "),
        ),
        body: Stack(
          children: <Widget>[
           FutureBuilder<List<Article>> (
            future:  NewsApiHttpClient.getNewsArticles(),
            builder: (context,snapshot){
              print("Data News Length : ${snapshot.hasData}");
              if(!snapshot.hasData){
                  return ListView.builder(itemBuilder: (context,index){
                    return Container(
                      child: Card(
                        color: Colors.black54,
                      ),
                      decoration: BoxDecoration(
                       border: Border.all(color: Colors.grey,width: 0.1,style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      height: 200,

                    );
                  },itemCount: 6,);
              }else{
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    Article article = snapshot.data[index];
                    return InkWell(
                      child: Card(
                        //color: Colors.orangeAccent[100],
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(

                                child: SlideFadeTransition(
                                  child: Text(
                                    article.title,
                                    style: title_text_style_1,
                                  ),
                                  animationDuration: Duration(seconds: 2),
                                  curve: Curves.bounceInOut,
                                  direction: Direction.horizontal,

                                ) ,
                              ),
                              Container(
                                child: Image.network(
                                  article.urlToImage == null ? "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSkg4K0Ik2F_kT_ORMhDAUAB-09e6wf-W4crUMxbljpeUOqY_NU" : article.urlToImage,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null)
                                      return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                                            : null,
                                      ),
                                    );
                                  },

                                ),
                              ),
                              Container(
                                child: Text(
                                  article.description != null?article.description.trim():"",
                                  style: paragraph_text_style1,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        //Navigator.pushNamed(context, "/newswebview");
                        /*Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>NewsWebView(url: article.url,)));*/
                        Navigator.pushNamed(context, "/newswebview",arguments: article.url);
                      },
                    );
                  },
                );
              }

            },
          ),
            //SampleAnimation(),
          ]
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: AnimatedContainer(
                duration: Duration(seconds: 1),

                child: Icon(
                  Icons.perm_identity,
                  size: isActive ? 30 :40,
                ),
              ),
              title: Text("profile"),
              //activeIcon: Icon(Icons.perm_identity,color: Colors.grey,)

            ),
            BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: Duration(seconds: 1),

                  child: Icon(
                    Icons.home,
                   // size: isActive ? 20 :30,
                  ),
                ),
                title: Text("home"),
                activeIcon: Icon(Icons.home,color: Colors.grey,)
            )
          ],
          onTap: (value){
            updateBottomActive();
          },
        ),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.perm_identity),
          onPressed: (){
            //String username ="Ravindra Babu";
            //Navigator.pushNamed(context, '/user',arguments:username );
            var route = MaterialPageRoute(builder: (context)=> FillIntheBlankExample());
            Navigator.push(context, route);
          },
        ),
      );

  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  ///The child on which to apply the given [SlideFadeTransition]
  final Widget child;

  ///The offset by which to slide and [child] into view from [Direction].
  ///Defaults to 1.0
  final double offset;

  ///The curve used to animate the [child] into view.
  ///Defaults to [Curves.easeIn]
  final Curve curve;

  ///The direction from which to animate the [child] into view. [Direction.horizontal]
  ///will make the child slide on x-axis by [offset] and [Direction.vertical] on y-axis.
  ///Defaults to [Direction.vertical]
  final Direction direction;

  ///The delay with which to animate the [child]. Takes in a [Duration] and
  /// defaults to 0.0 seconds
  final Duration delayStart;

  ///The total duration in which the animation completes. Defaults to 800 milliseconds
  final Duration animationDuration;

  SlideFadeTransition({
    @required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });
  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animationSlide;

  AnimationController _animationController;

  Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    //configure the animation controller as per the direction
    if (widget.direction == Direction.vertical) {
      _animationSlide =
          Tween<Offset>(begin: Offset(0, widget.offset), end: Offset(0, 0))
              .animate(CurvedAnimation(
            curve: widget.curve,
            parent: _animationController,
          ));
    } else {
      _animationSlide =
          Tween<Offset>(begin: Offset(widget.offset, 0), end: Offset(0, 0))
              .animate(CurvedAnimation(
            curve: widget.curve,
            parent: _animationController,
          ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
          curve: widget.curve,
          parent: _animationController,
        ));

    Timer(widget.delayStart, () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}

class TextSlideAnimation extends StatefulWidget{


  _TextSlideAnimationState createState(){
    return _TextSlideAnimationState();
  }
}
class _TextSlideAnimationState extends State<TextSlideAnimation>{
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class SampleAnimation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      body:Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height*0.85,
                minHeight: MediaQuery.of(context).size.height*0.1,
              ),
              child: Text("I 'm Big"),
              curve: Curves.bounceInOut,

            ),

          ),

        ],
      ) ,
    );
  }
}