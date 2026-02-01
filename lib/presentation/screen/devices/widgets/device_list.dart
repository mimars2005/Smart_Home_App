import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ListDevice extends StatefulWidget {
  ListDevice(
      {super.key,
      required this.state,
      required this.image,
      required this.name,
      required this.fromTime,
      required this.method});

  bool state;
  final Widget image;
  final String name;
  final String fromTime;
  final VoidCallback method;

  @override
  State<ListDevice> createState() => _ListDeviceState();
}

class _ListDeviceState extends State<ListDevice> {
  Color stateColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 127,
      child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        style: ButtonStyle(
            surfaceTintColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
            overlayColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(0, 68, 67, 67))),
        icon: Container(
          decoration: const BoxDecoration(
            border: GradientBoxBorder(
                width: 0.75,
                gradient: LinearGradient(
                  transform: GradientRotation(4.5),
                  colors: [
                    Color.fromARGB(0, 124, 164, 141),
                    Color.fromARGB(27, 255, 255, 255),
                  ],
                )),
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(25, 20),
                top: Radius.elliptical(25, 20)),
            gradient: LinearGradient(colors: [
              Color.fromARGB(85, 70, 113, 119),
              Color.fromARGB(71, 108, 137, 147)
            ], stops: [
              0.6,
              1
            ]),
          ),
          child: SizedBox(
            height: 110,
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                                  "asset/thermostat_cut.png",
                                  scale: 7,
                                 color: const Color.fromARGB(255, 123, 154, 233),
                                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text(
                    widget.state ? "On" : "Off",
                    style: GoogleFonts.sen(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          widget.method.call();
        },
      ),
    );
  }
}
