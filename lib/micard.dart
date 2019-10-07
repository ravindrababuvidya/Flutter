import 'package:flutter/material.dart';
void main()=>runApp(MyHome());
class MyHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:AssetImage(
                              "images/watch.png"
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              "tulips flower",
              style: TextStyle(
                fontFamily: "Pacifico",
                fontWeight: FontWeight.w700,
                fontSize: 40.0,

              ),
            ),
            Text(
              "Tulips (Tulipa) form a genus of spring-blooming perennial herbaceous bulbiferous geophytes. ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20.0
              ),
            ),
            SizedBox(
              height: 10.0,
              width: 200.0,
              child: Divider(
                color: Colors.teal.shade600,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0
              ),
              child: ListTile(
                leading: Icon(
                    Icons.phone
                ),
                title: Text(
                  "+91 7827847847487",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0
              ),
              child: ListTile(
                leading: Icon(
                    Icons.email
                ),
                title: Text(
                  "tulip@gmail.com",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}