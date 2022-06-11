import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_repo.dart';
import 'package:weather/weather_item.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepo _weatherRepo = WeatherRepo();

  WeatherCubit() : super(WeatherState());

  void fetchWeather() async {
    emit(WeatherState(isLoading: true));
    List<WeatherItem> weathers = await _weatherRepo.fetchWeather();
    emit(WeatherState(weathers: weathers));
  }
}

class WeatherState {
  final List<WeatherItem> weathers;
  final bool isLoading;

  WeatherState({this.isLoading = false, this.weathers = const []});
}
