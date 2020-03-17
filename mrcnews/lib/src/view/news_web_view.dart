import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsWebView extends StatelessWidget{
   String url;
  NewsWebView({this.url});
  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    url = settings.arguments;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("News Web View"),actions: <Widget>[
        RaisedButton(
          onPressed: (){
            Navigator.pushNamed(context, "/home",);
          },
          child: Icon(Icons.home),
        )
      ],),
      body: WebviewScaffold(
        url: url,
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: (){
          Navigator.pushNamed(context, "/home",);
        },
      ),
    );
    throw UnimplementedError();
  }
}