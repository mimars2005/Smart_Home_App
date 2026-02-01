// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home/data/repository/database_impl.dart';
import 'package:smart_home/data/repository/weather_impl.dart';
import 'package:smart_home/data/static/dataContainer.dart';
import 'package:smart_home/domain/model/weather.dart';
import 'package:smart_home/presentation/screen/add_device/add_device.dart';
import 'package:smart_home/presentation/screen/background.dart';
import 'package:smart_home/presentation/screen/dashboard/widgets/bottomNav.dart';
import 'package:smart_home/presentation/screen/dashboard/widgets/device.dart';
import 'package:smart_home/presentation/screen/dashboard/widgets/power_consumption.dart';
import 'package:smart_home/presentation/screen/dashboard/widgets/temperature.dart';
import 'package:smart_home/presentation/screen/devices/devices.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DatabaseRepositoryImpl? database = DatabaseRepositoryImpl();
  WeatherRepositoryImpl? weather = WeatherRepositoryImpl();

  Color iconBackground = const Color.fromARGB(255, 210, 232, 229);

  bool addDeviceScreenVisible = false;
  Weather forecastData =
      Weather(newTemp: 0, newFeelsLike: 0, newDescrp: "No data");

  final _pageController = PageController(initialPage: 0);

  void refresh() {
    setState(() {});
  }

  void toggleAddDeviceScreen() {
    setState(() {
      addDeviceScreenVisible = !addDeviceScreenVisible;
    });
  }

  Future<void> getData() async {
    await database!
        .getDevicesCount(DataContainer.username, DataContainer.password);
    forecastData = await weather!.getForecast();

    log(forecastData.temp.toString());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        elevation: 50,
        hoverColor: Colors.blue,
        child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  transform: GradientRotation(3.9),
                  colors: [
                    Color.fromARGB(255, 134, 89, 234),
                    Color.fromARGB(255, 226, 134, 229),
                  ],
                  stops: [
                    0.4,
                    1
                  ]),
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(195, 27, 209, 233).withOpacity(0.3),
                  spreadRadius: 20,
                  blurRadius: 50,
                  offset: const Offset(0, 44),
                ),
              ],
            ),
            child: IconButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent)),
              icon: Icon(Icons.add, color: Colors.white, size: 28),
              onPressed: () {
                toggleAddDeviceScreen();
              },
            )),
      ),
      bottomNavigationBar: BottomNav(
        isAddDeviceShown: addDeviceScreenVisible,
        pageController: _pageController,
      ),
      backgroundColor: Color.fromARGB(255, 181, 236, 244),
      body: StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 15)),
          builder: (context, snapshot) {
            return FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  return Stack(
                    children: [
                      PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          children: [
                            Stack(
                              children: [
                                Background(),
                                Padding(
                                  padding: EdgeInsets.only(top: 35),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: height * 0.7 / 10,
                                            width: height * 0.7 / 10,
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    230, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(80)),
                                            child: Icon(
                                              Icons.menu,
                                              size: 20,
                                            ),
                                          ),
                                          Padding(padding: EdgeInsets.all(15)),
                                          GradientText(
                                            "SmartHome",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                            gradient:
                                                LinearGradient(colors: const [
                                              Color.fromARGB(255, 123, 96, 219),
                                              Color.fromARGB(255, 159, 91, 204),
                                              Color.fromARGB(
                                                  255, 216, 104, 222),
                                            ], stops: const [
                                              0.05,
                                              0.5,
                                              0.7
                                            ]),
                                          ),
                                          Padding(padding: EdgeInsets.all(15)),
                                          Container(
                                            height: height * 0.7 / 10,
                                            width: height * 0.7 / 10,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    230, 255, 255, 255),
                                                borderRadius:
                                                    BorderRadius.circular(80)),
                                            child: Image.asset(
                                                "asset/profile_icon.png"),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Devices',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DataContainer.devicesData.isEmpty
                                          ? Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextButton(
                                                style: ButtonStyle(
                                                    overlayColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            Colors
                                                                .transparent)),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      20 /
                                                      100,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Text("Add device"),
                                                ),
                                                onPressed: () {
                                                  toggleAddDeviceScreen();
                                                },
                                              ),
                                            )
                                          : SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  20 /
                                                  100,
                                              child: ListView.builder(
                                                shrinkWrap: false,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: DataContainer
                                                    .devicesData.length,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 20.0,
                                                      ),
                                                      child: Device(
                                                          width: width * 3 / 10,
                                                          name: ((DataContainer
                                                                          .devicesData[
                                                                      index])!
                                                                  .keys
                                                                  .first
                                                                  .type)
                                                              .toString(),
                                                          icon: Image.asset(
                                                            ((DataContainer.devicesData[index])!
                                                                            .keys
                                                                            .first
                                                                            .type)
                                                                        .toString() ==
                                                                    "thermostat"
                                                                ? "asset/thermostat.png"
                                                                : ((DataContainer.devicesData[index])!.keys.first.type)
                                                                            .toString() ==
                                                                        "fire alarm"
                                                                    ? "asset/fire_alarm.png"
                                                                    : "",
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    123,
                                                                    154,
                                                                    233),
                                                            scale: 7,
                                                          ),
                                                          count: DataContainer
                                                              .devicesData[
                                                                  index]!
                                                              .values
                                                              .first));
                                                },
                                              ),
                                            ),
                                      SizedBox(
                                          height: height * 2.6 / 10,
                                          child: TemperatureData(
                                            weather: forecastData,
                                          )),
                                      Padding(padding: EdgeInsets.all(5)),
                                      PowerConsumption(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            DevicesScreen(
                              showAddDevice: toggleAddDeviceScreen,
                              method: refresh,
                              pageController: _pageController,
                            )
                          ]),
                      Visibility(
                        visible: true,
                        child: AnimatedOpacity(
                          opacity: addDeviceScreenVisible ? 1 : 0,
                          duration: Duration(milliseconds: 500),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: addDeviceScreenVisible
                                    ? MediaQuery.of(context).size.height
                                    : 0,
                                width: MediaQuery.of(context).size.width,
                                color: Color.fromARGB(0, 255, 255, 255),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: AddDevice()),
                                )),
                          ),
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.gradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
