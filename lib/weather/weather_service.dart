import 'dart:developer';

import 'package:app_architecture/weather/models/weather_model.dart';
import 'package:dio/dio.dart';

class WeatherService {
  late Dio _dio;
  WeatherService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/2.5",
      ),
    );
  }
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    Map<String, dynamic> params = {
      "q": cityName,
      "appid": "beb21568d0fab64759d7399ec43b8e33",
      "units": "metric",
      "lang": "fr",
    };
    Response resp = await _dio.get(
      "/weather",
      queryParameters: params,
    );

    return WeatherModel.fromJson(resp.data);
  }
}
