import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:smart_home/data/repository/database_impl.dart';
import 'package:smart_home/data/static/dataContainer.dart';

class DeviceUngradient extends StatefulWidget {
  DeviceUngradient(
      {super.key,
      required this.state,
      required this.deviceId,
      required this.image,
      required this.name,
      required this.value,
      required this.fromTime,
      required this.method});

  bool state;
  final Widget image;
  final String name;
  final int deviceId;
  final double value;
  final String fromTime;
  final VoidCallback method;

  @override
  State<DeviceUngradient> createState() => _DeviceUngradientState();
}

class _DeviceUngradientState extends State<DeviceUngradient> {
  Color stateColor = const Color.fromARGB(255, 129, 76, 175);
  DatabaseRepositoryImpl database = DatabaseRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      style: ButtonStyle(
          surfaceTintColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
          overlayColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromARGB(0, 255, 17, 17))),
      icon: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                height: 120,
                width: 120,
                margin: EdgeInsets.only(top: 10),
                child: widget.image),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(85, 70, 113, 119),
                Color.fromARGB(71, 108, 137, 147)
              ], stops: [
                0.6,
                1
              ]),
              border: const GradientBoxBorder(
                  width: 2,
                  gradient: LinearGradient(
                    transform: GradientRotation(4.5),
                    colors: [
                      Color.fromARGB(0, 124, 164, 141),
                      Color.fromARGB(27, 255, 255, 255),
                    ],
                  )),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text(
                          widget.state ? "ON" : "OFF",
                          style: GoogleFonts.sen(
                              color: widget.state
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 212, 212, 212),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width * 15 / 100,
                        child: Switch(
                          value: widget.state,
                          onChanged: (value) {
                            setState(() {
                              database.changeDeviceState(
                                  widget.deviceId,
                                  !widget.state,
                                  DataContainer.username,
                                  DataContainer.password);
                              widget.state = !widget.state;
                            });
                          },
                          trackOutlineWidth:
                              MaterialStateProperty.resolveWith((states) => 0),
                          thumbColor: MaterialStateColor.resolveWith(
                              (states) => Colors.white),
                          thumbIcon: MaterialStateProperty.resolveWith(
                              (states) => const Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                  )),
                          trackColor: MaterialStateColor.resolveWith((states) =>
                              widget.state
                                  ? const Color.fromARGB(189, 125, 97, 168)
                                  : const Color.fromARGB(170, 79, 138, 154)),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 50,
                    margin: EdgeInsets.only(
                      left: 16,
                      bottom: 20,
                    ),
                    child: Text(
                      (widget.name.contains("fire alarm")
                              ? (widget.value.toString() == 1 ? "Fire" : "Safe")
                              : widget.value.toString()) +
                          "" +
                          (widget.name == "thermostat" ? "°" : ""),
                      style: GoogleFonts.sen(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  widget.name,
                  style: GoogleFonts.sen(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      onPressed: () {
        if (widget.name == "AC") {
          widget.method.call();
        }
      },
    );
  }
}
