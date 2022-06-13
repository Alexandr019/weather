import 'package:weather/dto/daily_temp.dart';

class DailyForecast {
  final double currentTemp;
  final String location;
  final List<DayTemp> dayTempList;

  DailyForecast({
    required this.currentTemp,
    required this.location,
    required this.dayTempList,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) => DailyForecast(
        currentTemp: json['current']['temp'],
        location: json['timezone'],
        dayTempList: DayTemp.fromJsonList(json['daily']),
      );
}
