import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meteoapp/Model/meteoModel.dart';

class WeatherServices {
  fetchWeather() async {
    final response = await http.get(
      Uri.parse(
        //"https://api.openweathermap.org/data/2.5/weather?lat=28.5175&lon=81.7787&appid=509079b22fae7e954dff8403ef5eba0e",
        "https://api.openweathermap.org/data/2.5/weather?lat=48.8566&lon=2.3522&appid=509079b22fae7e954dff8403ef5eba0e",
      ),
    );
    // now we can cange latitude and longitude and let's see how it perfrom.
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        WeatherData wear = WeatherData.fromJson(json);
        print("rrrrrrrrrrrrrrrrrrrrrr");
        print(wear.name);
        print("fffffffffffffffffffffffffffffffffffffffff");
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load Weather data');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //fonction pour rechercher pas ville
  Future<WeatherData?> fetchWeatherByName(
    String name,
    BuildContext context,
  ) async {
    http.Response response;

    if (name.isEmpty) {
      response = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?lat=48.8566&lon=2.3522&appid=509079b22fae7e954dff8403ef5eba0e",
        ),
      );
    } else {
      response = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$name&appid=509079b22fae7e954dff8403ef5eba0e',
        ),
      );
    }

    print('${response.statusCode}');

    if (response.statusCode == 200) {
      return WeatherData.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    } else {
      return null; // évite le crash
    }
  }
}
// replace the api key with your api key thay openWeathemap provide you
// for your current location provide the longitude and latitude of your current location