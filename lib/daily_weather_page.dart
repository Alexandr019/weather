import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_cubit.dart';
import 'package:intl/intl.dart';

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
          scaffoldBackgroundColor: const Color(0xff4588D7)),
      home: BlocBuilder(
          bloc: _weatherCubit,
          builder: (context, WeatherState state) {
            return Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                // iconTheme: const IconThemeData(
                //   color: Colors.white,
                // ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "DAILY FORECAST",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 70, bottom: 10),
                          child: Text(
                            state.dailyweathers!.currentTemp
                                    .round()
                                    .toString() +
                                '℃',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 78.0,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                        padding: const EdgeInsets.only(bottom: 40),
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
                            itemCount: state.dailyweathers!.dayTempList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 25, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff266FB6).withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5, right:10, left: 10, bottom: 5),
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
                                      padding: const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
                                      child: Text(
                                        state.dailyweathers!.dayTempList[index]
                                                .temp
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
            );
          }),
    );
  }
}
