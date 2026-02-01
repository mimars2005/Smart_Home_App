import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_home/domain/model/weather.dart';
import 'package:smart_home/domain/repository/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  static WeatherRepositoryImpl? instance;

  WeatherRepositoryImpl._internal();

  factory WeatherRepositoryImpl() {
    instance ??= WeatherRepositoryImpl._internal();
    return instance!;
  }

  String url =
      "";

  Dio dio = Dio();

  @override
  Future<Weather> getForecast() async {
    var data = await dio.get(url);

    //log(data.toString());
    try {
      Map<String, dynamic> jsonData = jsonDecode(data.toString());
      Weather weather = Weather(
          newTemp: double.parse(jsonData["main"]["temp"].toString()),
          newFeelsLike: double.parse(jsonData["main"]["feels_like"].toString()),
          newDescrp:
              FormatDesc(jsonData["weather"][0]["description"].toString()));
      return weather;
    } catch (ex) {
      log(ex.toString());
    }
    return Weather(newTemp: 0, newFeelsLike: 0, newDescrp: "No info");
  }

  String FormatDesc(String desc) {
    List<String> words = desc.split(" ");
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(" ");
  }
}
