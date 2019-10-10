import 'package:flutter/material.dart';
class MainPage extends StatelessWidget{
  final TextStyle textStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: FlatButton(
              child: Text(
                  "First Screen",
                  style: textStyle,
              ),

              onPressed: (){
                Navigator.pushNamed(context, "/first");
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
            child: Text(
                "Second Screen",
                 style: textStyle,
            ),
            onPressed: (){
              Navigator.pushNamed(context, "/second");
            },
          ),
        ],
      ),
    );
  }
}