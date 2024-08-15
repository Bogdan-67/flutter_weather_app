import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';

import '../utilties/forecast_util.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecast> snapshot, int index) {
  var forecastList = snapshot.data?.list;
  DateTime date = DateTime.fromMillisecondsSinceEpoch(
      (forecastList?[index].dt ?? DateTime.now().millisecondsSinceEpoch) *
          1000);
  var formattedDate = Util.getFormattedDate(date);
  var dayOfWeek = formattedDate.split(',')[0];

  var tempMin = forecastList?[index].temp?.min?.toStringAsFixed(1);
  var icon = forecastList?[index].getIconUrl();

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            dayOfWeek,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '$tempMin C',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  if (icon != null)
                    Image.network(
                      icon,
                      scale: 1.2,
                      color: Colors.white,
                    )
                ],
              )
            ],
          )
        ],
      )
    ],
  );
}
