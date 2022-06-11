import 'package:weather/dto/hour_temp.dart';

class HourlyForecast {
  final double currentTemp; // TODO change it to int
  final String location;
  final List<HourTemp> hourTempList;

  HourlyForecast({
    required this.currentTemp,
    required this.location,
    required this.hourTempList,
  });
}
