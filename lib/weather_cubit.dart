import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/dto/hourly_forecast.dart';
import 'package:weather/weather_repo.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo _weatherRepo = WeatherRepo();

  WeatherCubit() : super(WeatherState());

  void fetchWeather() async {
    emit(WeatherState(isLoading: true));
    final HourlyForecast weathers = await _weatherRepo.fetchWeather();
    emit(WeatherState(weathers: weathers));
  }
}

class WeatherState {
  final HourlyForecast? weathers;
  final bool isLoading;

  WeatherState({this.isLoading = false, this.weathers});
}
