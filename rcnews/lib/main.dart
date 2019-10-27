import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'guillotine.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Intro Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: Scaffold(

        backgroundColor: Colors.cyan,
        appBar: AppBar(
          leading: InkWell(
              child: Icon(Icons.menu),
              onTap: (){
                print("Do something");
              },
          ),

        ),
        body: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "First Name :",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                          )
                      ),
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "First Name",
                            hintText: "Enter Text Here",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                          ),
                          onChanged: (firstName){
                            print(firstName);
                          },
                        ),

                      )
                    ],
                  ),

                ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Last Name :",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                    Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            hintText: "Enter Text Here",
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                        ),
                        onChanged: (lastName){
                          print(lastName);
                        },
                      ),

                    )
                  ],
                ),

              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text("Gender"),
                    Radio(
                      value: "Male",
                      activeColor: Colors.white,
                      onChanged: (genderValue){
                        print(genderValue);
                      },
                    ),
                    Text(
                      "Male"
                    ),
                    Radio(
                      value: "Female",
                      activeColor: Colors.white,
                      onChanged: (genderValue){
                        print(genderValue);
                      },
                    ),
                    Text(
                        "Female"
                    )
                  ],
                ),
              ),
              Card(
                //shape:CircleBorder(),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Image(image: AssetImage(
                                "assets/images/19621.jpg",

                            ),
                             // height: 400,
                              fit: BoxFit.fill,
                            ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 2,
                          child:Column(
                            children: <Widget>[
                              Text("Hi Ravindra "),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: FlatButton(
                                      child: Icon(Icons.add),
                                      onPressed: (){
                                        print("Add something ");
                                      },
                                    ),
                                  ),
                                  FlatButton(
                                    child: Icon(Icons.add),
                                    onPressed: (){
                                      print("Add something ");
                                    },
                                  )
                                ],
                              ),
                              Container(
                                //height: 200,
                                //width: 200,
                                child: Text("Green"),
                                color: Colors.green,
                              )
                            ],
                          ) ,
                        )
                      ],
                    )

                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}