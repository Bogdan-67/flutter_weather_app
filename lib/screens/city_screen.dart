import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: const InputDecoration(
                    hintText: 'Enter City Name',
                    border: OutlineInputBorder(),
                    icon: Icon(
                      Icons.location_city,
                      size: 50,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, cityName);
              },
              child: Text(
                'Get Weather',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
