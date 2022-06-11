import 'package:dio/dio.dart';
import 'package:weather/weather_item.dart';

class WeatherRepo {
  Future<List<WeatherItem>> fetchWeather() async {
    final json = await Dio().get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=10&lon=10&exclude=current,minutely,alerts&appid=359526b5c972687b79dcf6cce9b189f8');

    final data = json.data;

    List list = data['results'];

    return list.map((e) => WeatherItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}