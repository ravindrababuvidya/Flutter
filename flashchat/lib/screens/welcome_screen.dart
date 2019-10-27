import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'roundbutton.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      //upperBound: 100.0,
    );

    // animation widget creation

    //animation = CurvedAnimation(parent: controller,curve: Curves.easeInOut);

    animation = ColorTween(begin: Colors.lightBlue,end: Colors.white).animate(controller);

    /*if(animation.status == AnimationStatus.completed){
      controller.reverse(from: 1.0);
    }else if(animation.status == AnimationStatus.dismissed){
      controller.forward();
    }*/
    controller.forward();
    animation.addStatusListener((status){
      /* if(status == AnimationStatus.completed){
          controller.reverse(from: 1.0);
        }else if(status == AnimationStatus.dismissed){
          controller.forward();
        }
      */
    });

    controller.addListener((){
      setState(() {
        //print(controller.value);
        print(animation.value);
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey.withOpacity(controller.value),
      //backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TyperAnimatedTextKit(
                  text:['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(color: Colors.lightBlueAccent,buttonName: "Login",onpressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            }),
            RoundButton(color: Colors.blueAccent,buttonName: "Register",onpressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            }),
          ],
        ),
      ),
    );
  }
}