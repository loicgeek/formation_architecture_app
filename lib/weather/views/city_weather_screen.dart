import 'package:app_architecture/app/widgets/app_future_builder.dart';
import 'package:app_architecture/weather/models/weather_model.dart';
import 'package:app_architecture/weather/weather_service.dart';
import 'package:flutter/material.dart';

class CityWeatherScreen extends StatefulWidget {
  const CityWeatherScreen({Key? key}) : super(key: key);

  @override
  State<CityWeatherScreen> createState() => _CityWeatherScreenState();
  static route() =>
      MaterialPageRoute(builder: (context) => const CityWeatherScreen());
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  late WeatherService _service;
  late Future<WeatherModel> _weatherFuture;
  late TextEditingController _cityNameController;
  String cityName = 'Douala';
  @override
  void initState() {
    _service = WeatherService();
    _weatherFuture = _service.getWeatherByCity(cityName);
    _cityNameController = TextEditingController(text: cityName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _cityNameController,
          ),
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _weatherFuture =
                    _service.getWeatherByCity(_cityNameController.text);
              });
            },
            label: Text("Search"),
            icon: Icon(Icons.search),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: AppFutureBuilder<WeatherModel>(
              future: _weatherFuture,
              onError: (e) {
                return Container(
                  child: Text("$e"),
                );
              },
              onData: (data) {
                var weather = data!;
                return ListView(children: [
                  Container(
                    child: Text("${weather.cityName}"),
                  ),
                  ListTile(),
                ]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
