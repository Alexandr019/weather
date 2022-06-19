import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/custom_scaffold.dart';
import 'package:weather/gradient_background.dart';
import 'package:weather/weather_cubit.dart';

void main() {
  runApp(const Second());
}

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Second> {
  late WeatherCubit _weatherCubit;

  @override
  void initState() {
    super.initState();
    setState(() {
      _weatherCubit = WeatherCubit()..fetchDailyWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.transparent
      ),
      home: BlocBuilder(
          bloc: _weatherCubit,
          builder: (context, WeatherState state) {
            return GradientBackground(
              child: CustomScaffold(
                text: 'DAILY FORECAST',
                needToShowButton: true,
                body: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                              0,
                              0.35,
                              0.64,
                              0.82,
                              1,
                            ],
                            colors: [
                              Color(0xff4588D7),
                              Color(0xff82B8E7),
                              Color(0xffD7CCC2),
                              Color(0xffF1D2B0),
                              Color(0xffF5B376),
                            ],
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 100, bottom: 10),
                              child: Text(
                                state.dailyweathers!.currentTemp
                                        .round()
                                        .toString() +
                                    '℃',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 100.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Text(
                                state.dailyweathers!.location,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount:
                                    state.dailyweathers!.dayTempList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff66A6E3)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              right: 10,
                                              left: 10,
                                              bottom: 5),
                                          child: Text(
                                            DateFormat('EE (dd.MM)').format(state
                                                .dailyweathers!
                                                .dayTempList[index]
                                                .time),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              right: 10,
                                              left: 10,
                                              bottom: 5),
                                          child: Text(
                                            state.dailyweathers!
                                                    .dayTempList[index].temp
                                                    .round()
                                                    .toString() +
                                                '℃',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24.0,
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
                          ],
                        ),
                      ),
              ),
            );
          }),
    );
  }
}
