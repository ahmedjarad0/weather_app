import 'dart:convert';

import 'package:weather_app/services/location.dart';

import '../helper/constants.dart';
import 'package:http/http.dart' as http;

class NetworkHelper{
  Future<Map<String,dynamic>> getWeather(Location location) async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=$apiKey&units=metric');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('Something error ,try again');
  }  Future<Map<String,dynamic>> getCityData(String city) async {
    Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return Future.error('Something error ,try again');
  }

}