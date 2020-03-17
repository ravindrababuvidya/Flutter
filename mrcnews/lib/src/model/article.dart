class Article {
  String author, title, description, url, urlToImage, publishedAt, content;
  Article(
      {this.author,
      this.title,
      this.description,
      this.content,
      this.publishedAt,
      this.url,
      this.urlToImage});

  Article.fromJson(Map<String , dynamic> parsedJson){
    author = parsedJson['author'];
    title = parsedJson['title'];
    description = parsedJson['description'];
    content = parsedJson['content'];
    publishedAt = parsedJson['publishedAt'];
    url = parsedJson['url'];
    urlToImage = parsedJson['urlToImage'];
  }

}

