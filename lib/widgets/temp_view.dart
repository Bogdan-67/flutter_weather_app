import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const TempView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var icon = forecastList?[0].getIconUrl();
    var temp = forecastList?[0].temp?.day?.toStringAsFixed(1);
    var description = forecastList?[0].weather?[0].description?.toUpperCase();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Image.network(
              icon,
              scale: 0.6,
              color: Colors.black54,
            ),
          SizedBox(width: 10),
          Column(
            children: [
              Text(
                '$temp C',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '$description',
              )
            ],
          )
        ],
      ),
    );
  }
}
