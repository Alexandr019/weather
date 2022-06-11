import 'package:dio/dio.dart';
import 'package:weather/dto/hourly_forecast.dart';

class WeatherRepo {
  Future<HourlyForecast> fetchWeather() async {
    final json = await Dio().get(
        'https://api.openweathermap.org/data/2.5/onecall?lat=10&lon=10&exclude=minutely,alerts&units=metric&appid=ae838f7817f1909899a9bc98b741eb36');

    final data = json.data;

    return HourlyForecast.fromJson(data);
  }
}
