class WeatherItem {
  final double lat;
  final double lon;
  final String timezone;
  final double temp;
  final String main;


  WeatherItem({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.temp,
    required this.main,

  });

  factory WeatherItem.fromJson(Map<String, dynamic> json) => WeatherItem(
    lat: json['lat'] ?? '',
    lon: json['lon'] ?? '',
    timezone: json['timezone'] ?? '',
    temp: json['main']['temp'] ?? '',
    main: json["weather"]['main'] ?? '',
  );
}
