import 'dart:convert';

import 'package:flutter_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_weather_app/utilties/const.dart';
import 'package:http/http.dart' as http;

import '../utilties/location.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast(
      {String? cityName, bool isCity = false}) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String> queryParams;

    if (isCity) {
      queryParams = {
        'q': cityName!,
        'units': 'metric',
        'cnt': '7',
        'appid': Constants.WEATHER_APP_ID
      };
    } else {
      queryParams = {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'units': 'metric',
        'cnt': '7',
        'appid': Constants.WEATHER_APP_ID
      };
    }

    var uri = Uri.https(Constants.WEATHER_BASE_URL_DOMAIN,
        Constants.WEATHER_FORECAST_PATH, queryParams);

    print('request: ${uri.toString()}');

    var response = await http.get(uri);

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
