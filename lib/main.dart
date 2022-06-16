import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather_cubit.dart';
import 'daily_weather_page.dart';
import 'package:intl/intl.dart';

void main() {
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
          scaffoldBackgroundColor: const Color(0xff4588D7),
      ),
      home: BlocBuilder(
          bloc: _weatherCubit,
          builder: (context, WeatherState state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "HOURLY FORECAST",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
                    padding: const EdgeInsets.only(
                        top: 120, bottom: 10),
                    child: Text(
                      state.weathers!.currentTemp.round().toString()+'℃',
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
                          margin: const EdgeInsets.only(top:90.0, left: 10.0,right: 10.0, bottom: 90.0),
                          decoration: BoxDecoration(
                            color: const Color(0xff66A6E3).withOpacity(0.4),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(padding: const EdgeInsets.only(top:10, left: 8, right: 8),
                                child: Text(
                                  DateFormat('EE').format(state
                                      .weathers!.hourTempList[index].time),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(top:30, left: 15, right: 15),
                                child: Text(
                                  DateFormat('HH:mm').format(state
                                      .weathers!.hourTempList[index].time),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  state.weathers!.hourTempList[index].temp.round().toString()+'℃',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Padding(padding: const EdgeInsets.only(top:25, left: 8, right: 8),
                                child: Text(
                                  state.weathers!.hourTempList[index].windSpeed.toString()+'km/h',
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
                  Padding(padding: const EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xff6FA4E2).withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))
                        ),
                        child: const Padding(padding: EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                          child: Text('7-DAY FORECAST',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Second()));
                        }),
                  )
                ],
              ),),
            );
          }),
    );
  }
}
