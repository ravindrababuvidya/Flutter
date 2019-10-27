import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'roundbutton.dart';
import 'package:flashchat/constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "register_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                  print(email);
                },
                decoration: kInputTextDecaration.copyWith(hintText: "Enter your email"),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                  print(password);
                },
                decoration: kInputTextDecaration.copyWith(hintText: "Enter your password"),
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(color: Colors.blueAccent,buttonName: "Register",onpressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try{
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser != null){
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {

                    showSpinner = false;
                  });
                  //print(email);
                }catch(e){
                  setState(() {

                    showSpinner = false;
                  });
                }

                //Navigator.pushNamed(context, RegistrationScreen.id);
              })
            ],
          ),
        ),
      ),
    );
  }
}