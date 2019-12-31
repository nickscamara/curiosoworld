import 'package:curiosoworld/model/country.dart';
import 'package:curiosoworld/model/travel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:curiosoworld/model/news.dart';
class RestInterface{


  static Future<List<Country>> getCountries(int amount) async {
  final response =
  await http.get('https://restcountries.eu/rest/v2/all');

  var data = await json.decode(response.body);
  var articles = data;
  print(articles);
  List<Country> list = [];
  int i = 0;
  for(var x in articles)
  {
    //print(x);
   Country news = new Country(x["name"], x["flag"]);//, x["description"], x["url"], x["urlToImage"], x["publishedAt"], x["content"]);
    list.add(news);
    i++;
    if(i==amount)
    {break;}
    
  }
 return list;

  // Use the compute function to run parsePhotos in a separate isolate.
}
  static Future<List<Travel>> getTravels() async{
    List<Travel> list = [
      new Travel("Juquehy", "assets/viagem1.jpg", "Curta Viagem pra Juquehy","assets/profile.jpg"),
        new Travel("Paris", "assets/viagem2.jpg", "Paris principal pontos turísticos","assets/profile_2.jpg"),
          new Travel("Disney", "assets/viagem3.jpg", "Viagem Disney Completa","assets/profile.jpg"),
            new Travel("San Diego", "assets/viagem4.jpg", "Charme de San Diego","assets/profile_2.jpg"),
              new Travel("New Hampshire", "assets/viagem5.jpg", "The Fall of NH","assets/profile.jpg"),
    ];
    return list;
  }
}