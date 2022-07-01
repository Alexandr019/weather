import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:weather/dto/daily_forecast.dart';
import 'package:weather/dto/hourly_forecast.dart';
import 'package:weather/services/location_service.dart';

class WeatherRepo {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _onecallEndpoint = '/onecall';

  Future<HourlyForecast> fetchWeather() async {
    final LocationData locationData = await LocationService.getLocation();
    final json = await Dio().get(
      baseUrl + _onecallEndpoint,
      queryParameters: {
        'lat': locationData.latitude,
        'lon': locationData.longitude,
        'exclude': 'minutely,alerts',
        'units': 'metric',
        'appid': 'ae838f7817f1909899a9bc98b741eb36',
      },
    );

    final data = json.data;

    return HourlyForecast.fromJson(data);
  }

  Future<DailyForecast> fetchDailyWeather() async {
    final LocationData locationData = await LocationService.getLocation();
    final json = await Dio().get(
      baseUrl + _onecallEndpoint,
      queryParameters: {
        'lat': locationData.latitude,
        'lon': locationData.longitude,
        'exclude': 'minutely,alerts',
        'units': 'metric',
        'appid': 'ae838f7817f1909899a9bc98b741eb36',
      },
    );

    final data = json.data;

    return DailyForecast.fromJson(data);
  }
}
