import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'location_screen.dart';
import 'package:http/http.dart' as http;

const  apiKey = "a116e62ed121aad1f400ab8290fb2311";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
double lattitude;
double longitude;
void geoLocation() async{
  Location location = Location();
  await location.getCurrentLocation();
  print(location.longitude);
  lattitude = location.latitude;
  print(location.latitude);
  longitude = location.longitude;
  getData();
}
  void getData() async{
      http.Response response= await http.get(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lattitude&lon=$longitude&appid=$apiKey");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen()));
      if(response.statusCode == 200){
        print(response.body);
        String weatherData = response.body;
        String weather = jsonDecode(weatherData)["weather"][0]['description'];
        print(weather);
        String cityName = jsonDecode(weatherData)["name"];
        print(cityName);
      }else{
        print(response.statusCode);
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();
    geoLocation();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
