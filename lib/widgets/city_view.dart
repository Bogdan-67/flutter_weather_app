import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_weather_app/utilties/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var milliseconds =
        (forecastList?[0].dt ?? DateTime.now().millisecondsSinceEpoch) * 1000;
    var date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    var formattedDate = Util.getFormattedDate(date);
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;

    return Container(
      child: Column(
        children: [
          Text(
            '$city, $country',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            formattedDate,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
