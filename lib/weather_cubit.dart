import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/dto/hourly_forecast.dart';
import 'package:weather/dto/daily_forecast.dart';
import 'package:weather/weather_repo.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo _weatherRepo = WeatherRepo();

  WeatherCubit() : super(WeatherState());

  void fetchWeather() async {
    emit(WeatherState(isLoading: true));
    final HourlyForecast weathers = await _weatherRepo.fetchWeather();
    emit(WeatherState(weathers: weathers));
  }
  void fetchDailyWeather() async {
    emit(WeatherState(isLoading: true));
    final DailyForecast dailyweathers = await _weatherRepo.fetchDailyWeather();
    emit(WeatherState(dailyweathers: dailyweathers));
  }
}

class WeatherState {
  final HourlyForecast? weathers;
  final DailyForecast? dailyweathers;
  final bool isLoading;

  WeatherState({this.isLoading = false, this.weathers, this.dailyweathers});
}
