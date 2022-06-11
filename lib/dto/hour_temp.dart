class HourTemp {
  final DateTime time;
  final double temp; // TODO change it to int

  HourTemp({required this.time, required this.temp});

  factory HourTemp.fromJson(Map<String, dynamic> json) => HourTemp(
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp: json['temp'],
      );

  static List<HourTemp> fromJsonList(List<dynamic> jsonList) {
    List<HourTemp> list = [];
    for (int i = 0; i < jsonList.length; i++) {
      list.add(HourTemp.fromJson(jsonList[i]));
    }
    return list;
  }
}
