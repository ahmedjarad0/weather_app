import 'package:weather_app/services/location.dart';

import 'networking.dart';


class WeatherModel {
 WeatherModel();

  Future<Map<String,dynamic>> getLocation() async {
    Location location = Location();
    await location.getLocationPosition();
    Map<String, dynamic> weatherData =
    await NetworkHelper().getWeather(location);
    return weatherData ;

  }



  String getWeatherIcon(int weatherId) {
    if (weatherId < 300) {
      return '🌩';
    } else if (weatherId < 400) {
      return '🌧';
    } else if (weatherId < 600) {
      return '☔️';
    } else if (weatherId < 700) {
      return '☃️';
    } else if (weatherId < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
