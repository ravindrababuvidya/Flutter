import 'dart:convert';

import 'package:mrcnews/src/model/article.dart';
import 'package:http/http.dart' as http;
import 'package:mrcnews/src/model/news_article.dart';

class NewsApiHttpClient {
  static Future<List<Article>> getNewsArticles() async{
    List<Article>  newsArticlesList = [];
    String URL = "http://newsapi.org/v2/top-headlines?country=in&apiKey=fce9360f69274a02bfc62c6c9c5c8477";
    var response =await http.get(URL);
    if(response.statusCode == 200){
      final articleJSONObject = json.decode(response.body);
     // print(articleJSONObject['articles']);

      //print(articleJSONObject.length);

      for(int i=0;i< articleJSONObject['articles'].length ; i++){
        newsArticlesList.add(Article.fromJson(articleJSONObject['articles'][i]));
      }


    }
  return newsArticlesList;
  }
  static Future<ArticleData> getNewsArticlesData() async{
   // getNewsArticles();
    ArticleData  newsArticlesList = null;
    String URL = "http://newsapi.org/v2/top-headlines?country=us&apiKey=fce9360f69274a02bfc62c6c9c5c8477";
    var response =await http.get(URL);
    if(response.statusCode == 200){
      var articleJSONObject = json.decode(response.body);
      //print(articleJSONObject['articles']);
      newsArticlesList = ArticleData.fromJson(articleJSONObject);
      print(newsArticlesList.articles.length);

    }
    return newsArticlesList != null ? newsArticlesList : null ;
  }
}