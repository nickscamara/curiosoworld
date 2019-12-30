import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:curiosoworld/model/news.dart';
class RestInterface{


  static Future<List<News>> getTopHeadlinesBrasil(int amount) async {
  final response =
  await http.get('https://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=086e6380f88c4239a4e92d8e8ee17b60');

  var data = await json.decode(response.body);
  var articles = data["articles"];
  List<News> list = [];
  int i = 0;
  for(var x in articles)
  {
    print(x);
   News news = new News(x["author"], x["title"], x["description"], x["url"], x["urlToImage"], x["publishedAt"], x["content"]);
    list.add(news);
    i++;
    if(i==amount)
    {break;}
    
  }
//  return data;

  // Use the compute function to run parsePhotos in a separate isolate.
  return list;
}

}