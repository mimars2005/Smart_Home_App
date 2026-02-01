import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:smart_home/domain/model/weather.dart';
import 'package:smart_home/presentation/screen/dashboard/Dashboard.dart';

class TemperatureData extends StatefulWidget {
  const TemperatureData({super.key, required this.weather});
  final Weather weather;
  @override
  State<TemperatureData> createState() => _TemperatureDataState();
}

class _TemperatureDataState extends State<TemperatureData> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 107, 207, 202),
                    Color.fromARGB(255, 85, 159, 155)
                  ],
                  transform: GradientRotation(-0.4),
                  stops: [0.4, 1]),
              borderRadius: BorderRadius.circular(37),
              border: const GradientBoxBorder(
                  width: 2,
                  gradient:
                      LinearGradient(transform: GradientRotation(2), colors: [
                    Color.fromARGB(184, 255, 255, 255),
                    Color.fromARGB(27, 255, 255, 255),
                    Color.fromARGB(255, 223, 223, 223)
                  ])),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    spreadRadius: 1,
                    color: Color.fromARGB(52, 0, 0, 0))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1.3 / 10,
                      child: GradientText(
                        "${double.parse(widget.weather.temp.toString()).round()}°",
                        style: const TextStyle(
                          fontSize: 85,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 243, 242, 242),
                        ),
                        gradient: const LinearGradient(stops: [
                          0.3,
                          0.7
                        ], colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 221, 253, 255)
                        ], transform: GradientRotation(1.5)),
                      ),
                    ),
                    Text(
                      "Feels like ${double.parse(widget.weather.feelsLike.toString()).round()}°",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 243, 242, 242),
                          fontWeight: FontWeight.w600,
                          fontSize: 17),
                    ),
                    Flexible(
                      child: Text(
                        widget.weather.descrp,
                        style: GoogleFonts.sen(
                            color: const Color.fromARGB(255, 243, 242, 242),
                            fontSize: 25,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 3.9 / 10,
              top: 0.2 / 10 * MediaQuery.of(context).size.height),
          height: 400,
          child: Image.asset("asset/cloud_thunder.png"),
        ),
      ],
    );
  }
}
