class DayTemp {
  final DateTime time;
  final double temp;

  DayTemp({required this.time, required this.temp});

  factory DayTemp.fromJson(Map<String, dynamic> json) => DayTemp(
        time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp: json['temp']['max'].toDouble(),
      );

  static List<DayTemp> fromJsonList(List<dynamic> jsonList) {
    List<DayTemp> list = [];
    for (int i = 0; i < jsonList.length; i++) {
      list.add(DayTemp.fromJson(jsonList[i]));
    }
    return list;
  }
}
