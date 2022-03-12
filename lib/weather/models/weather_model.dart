import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  @JsonKey(name: "name")
  final String cityName;
  @JsonKey(name: "main")
  final WeatherValue value;

  WeatherModel({
    required this.cityName,
    required this.value,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  /// Connect the generated [_$WeatherModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class WeatherValue {
  final double temp;
  @JsonKey(name: "feels_like")
  final double feelsLike;
  @JsonKey(name: "temp_min")
  final double tempMin;
  @JsonKey(name: "temp_max")
  final double tempMax;
  final double pressure;
  final double humidity;

  WeatherValue({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherValue.fromJson(Map<String, dynamic> json) =>
      _$WeatherValueFromJson(json);

  /// Connect the generated [_$WeatherValueToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$WeatherValueToJson(this);
}
