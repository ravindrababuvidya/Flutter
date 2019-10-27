import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(RCHomepage());

class RCHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: RCHomeScreenAnimation(),
    );
  }
}

class RCHomeScreenAnimation extends StatefulWidget {
  _RCHomeScreen createState() => _RCHomeScreen();
}

class _RCHomeScreen extends State<RCHomeScreenAnimation>
    with TickerProviderStateMixin {
  AnimationController splashAnimatorController;
  Animation<double> splashaAnimation;
  AnimationController _controller;

  Animation<Offset> moveleftToRight;
  Animation<Offset> movieRightToLeft;
  Animation<double> disappear;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    splashAnimatorController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    splashaAnimation = CurvedAnimation(
        parent: splashAnimatorController, curve: Curves.easeInOutCirc);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));

    splashAnimatorController.forward();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();

    moveleftToRight = Tween(begin:Offset(0.0,414),end: Offset(414,896) ).animate(_controller);

    movieRightToLeft = Tween(begin:Offset(414,896),end: Offset(0.0,414)).animate(_controller);

    disappear = Tween(begin: 1.0,end: 0.0).animate(_controller);



  }

  @override
  void dispose() {
    // TODO: implement dispose
    //splashAnimatorController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).size.width);
    // TODO: implement build
    final int percent = (_controller.value * 100.0).round();
    return Scaffold(
      appBar: AppBar(
        title: Text("RC NEWS"),
      ),
      body: new Container(
        child: new Center(
          child: new Text('$percent%'),
        ),
      ),
      /*body: Container(
            child: FadeTransition(
              opacity: splashaAnimation,
              child: Column(

                children: <Widget>[
                  Container(

                    height: MediaQuery.of(context).size.height/1.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(
                          "assets/images/19621.jpg"
                        ),
                        fit: BoxFit.fill,

                      ),
                    ),
                    child: FadeTransition(
                      opacity: splashaAnimation,
                      child: Center(
                        child: Text(
                          "RC NEWS",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 43,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

            ),
          ),*/
    );
  }
}
