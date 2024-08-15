import 'package:flutter/material.dart';
import 'package:flutter_weather_app/api/weather_api.dart';
import 'package:flutter_weather_app/models/weather_forecast_daily.dart';
import 'package:flutter_weather_app/screens/city_screen.dart';
import 'package:flutter_weather_app/widgets/bottom_list_view.dart';
import 'package:flutter_weather_app/widgets/city_view.dart';
import 'package:flutter_weather_app/widgets/detail_view.dart';
import 'package:flutter_weather_app/widgets/temp_view.dart';

// C:\Users\Bogdan\AppData\Local\Android\Sdk\tools\emulator.exe -avd Pixel_8 -dns-server 8.8.8.8

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;

  String _cityName = 'London';

  // String _cityName;

  @override
  void initState() {
    super.initState();
    forecastObject =
        WeatherApi().fetchWeatherForecastWithCity(cityName: _cityName);

    // forecastObject.then((weather) {
    //   print(weather.list![0].weather?[0].main);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.my_location),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var tappedName = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const CityScreen();
                }),
              );
              if (tappedName != null) {
                setState(() {
                  _cityName = tappedName;
                  forecastObject = WeatherApi()
                      .fetchWeatherForecastWithCity(cityName: _cityName);
                });
              }
            },
            icon: const Icon(Icons.location_city),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: FutureBuilder(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      CityView(snapshot: snapshot),
                      const SizedBox(
                        height: 20,
                      ),
                      TempView(snapshot: snapshot),
                      const SizedBox(
                        height: 20,
                      ),
                      DetailView(snapshot: snapshot),
                      const SizedBox(
                        height: 40,
                      ),
                      BottomListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
