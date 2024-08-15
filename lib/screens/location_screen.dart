import 'package:flutter/material.dart';
import 'package:flutter_weather_app/api/weather_api.dart';
import 'package:flutter_weather_app/screens/weather_forecast_screen.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationPermission permission;

  void getLocationData() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print('Permissions are denied forever, handle appropriately.');
        _showDialog();
        return;
      }

      if (permission == LocationPermission.denied) {
        print('Permissions are denied, next time you could try');
        _showDialog();
        return;
      }
    }
    var weatherInfo = await WeatherApi().fetchWeatherForecast();

    if (weatherInfo == null) {
      print('WeatherInfo was null: $weatherInfo');
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherForecastScreen(
        locationWeather: weatherInfo,
      );
    }));
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please give permission to your location'),
            content: permission == LocationPermission.deniedForever
                ? Text('Allow access to your location in device settings')
                : null,
            actions: [
              if (permission == LocationPermission.denied)
                TextButton(
                    onPressed: () async {
                      permission = await Geolocator.requestPermission();
                      if (permission != LocationPermission.deniedForever &&
                          permission != LocationPermission.denied) {
                        Navigator.pop(context);
                        getLocationData();
                      }
                    },
                    child: const Text('Request permission'))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
