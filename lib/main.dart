import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/custom_scaffold.dart';
import 'package:weather/gradient_background.dart';
import 'package:weather/weather_cubit.dart';

import 'daily_weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  late WeatherCubit _weatherCubit;

  @override
  void initState() {
    super.initState();
    setState(() {
      _weatherCubit = WeatherCubit()..fetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: BlocBuilder(
          bloc: _weatherCubit,
          builder: (context, WeatherState state) {
            return GradientBackground(
              child: CustomScaffold(
                text: 'HOURLY FORECAST',
                needToShowButton: false,
                body: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 120, bottom: 10),
                              child: Text(
                                state.weathers!.currentTemp.round().toString() +
                                    '℃',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 100.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Text(
                              state.weathers!.location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.weathers!.hourTempList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 90.0,
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 90.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff66A6E3)
                                          .withOpacity(0.4),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, left: 8, right: 8),
                                          child: Text(
                                            DateFormat('EE').format(state
                                                .weathers!
                                                .hourTempList[index]
                                                .time),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, left: 15, right: 15),
                                          child: Text(
                                            DateFormat('HH:mm').format(state
                                                .weathers!
                                                .hourTempList[index]
                                                .time),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10),
                                          child: Text(
                                            state.weathers!.hourTempList[index]
                                                    .temp
                                                    .round()
                                                    .toString() +
                                                '℃',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, left: 8, right: 8),
                                          child: Text(
                                            state.weathers!.hourTempList[index]
                                                    .windSpeed
                                                    .toString() +
                                                'km/h',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xff6FA4E2)
                                          .withOpacity(0.6),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, bottom: 10, left: 50, right: 50),
                                    child: Text(
                                      '7-DAY FORECAST',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Second()));
                                  }),
                            )
                          ],
                        ),
                      ),
              ),
            );
          }),
    );
  }
}
