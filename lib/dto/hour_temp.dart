class HourTemp {
  final DateTime time;
  final double temp; // TODO change it to int
  final double? windSpeed;

  HourTemp({required this.time, required this.temp, required this.windSpeed});

  factory HourTemp.fromJson(Map<String, dynamic> json) => HourTemp(
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp: json['temp'].toDouble(),
        windSpeed: json['wind_speed'].toDouble(),
      );

  static List<HourTemp> fromJsonList(List<dynamic> jsonList) {
    List<HourTemp> list = [];
    for (int i = 0; i < jsonList.length; i++) {
      list.add(HourTemp.fromJson(jsonList[i]));
    }
    return list;
  }
}
