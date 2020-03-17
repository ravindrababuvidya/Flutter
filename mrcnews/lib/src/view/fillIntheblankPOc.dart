import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mrcnews/src/view/assement_multiplechoice.dart';
import 'package:mrcnews/src/view/errorpage.dart';

class FillIntheBlankExample extends StatefulWidget{
  _FillIntheBlankExampleState createState() =>_FillIntheBlankExampleState();
}
class _FillIntheBlankExampleState extends State<FillIntheBlankExample> with SingleTickerProviderStateMixin{
  AnimationController _controller ;
  Animation animation ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 5),vsync: this);
    animation = Tween<double>(begin: 0,end: 200).animate(_controller);
    animation.addStatusListener((status) { print("Status ${status}");});
    _controller.forward();


  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animation"),
          //bottom: TabBar(),
          leading: MaterialButton(
            onPressed: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
                child: AnimatedLogo(animation: animation)
            ),
            AnimateExample("Animation First Example",duration: Duration(seconds: 10),maxScale: 3.0,),
          ],
        //  child: AnimatedLogo1(animation: animation,),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          //onPressed: ()=>Navigator.pushNamedAndRemoveUntil(context,  "/multiple", (route) => false),
          onPressed: ()=>Navigator.pushNamed(context,  "/multiple1"),
        ),
      );
  }
}
class AnimateExample extends StatefulWidget{
  final String text;
  final double maxScale;
  final Duration duration;
  AnimateExample(this.text,{this.duration,this.maxScale});
  _AnimateExampleState createState()=>_AnimateExampleState();
}
class _AnimateExampleState extends State<AnimateExample> with SingleTickerProviderStateMixin{
  Animation<double> animation ;
  AnimationController controller;
  double textScale = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: widget.duration,vsync: this);
    final CurvedAnimation curvedAnimation = CurvedAnimation(parent: controller,curve: Curves.fastOutSlowIn);
    animation =  Tween<double>(begin: 0,end: widget.maxScale).animate(curvedAnimation)
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
      animation.addListener(() => setState(() => textScale = animation.value));
      controller.forward();
    });
  }
  @override
  Widget build(BuildContext context) {
    print(textScale);
    return Text(
      widget.text,
      style: TextStyle(
       // fontSize: textScale
        wordSpacing: textScale
      ),
    );
  }
}
class AnimatedLogo extends AnimatedWidget{
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    // TODO: implement build
    return Container(
      child: FlutterLogo(),
      width: animation.value,
      height: animation.value,
    );
  }

}

class AnimatedLogo1 extends AnimatedWidget{
   Animation<double> animation;
   AnimatedLogo1({Key key, this.animation});

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    // TODO: implement build
    return Container(
      child: FlutterLogo(),
      width: animation.value,
      height: animation.value,
    );
  }
  //TabBar();
}