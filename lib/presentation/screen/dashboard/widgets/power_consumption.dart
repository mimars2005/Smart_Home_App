import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:smart_home/data/static/dataContainer.dart';

class PowerConsumption extends StatefulWidget {
  const PowerConsumption({super.key});

  @override
  State<PowerConsumption> createState() => _PowerConsumptionState();
}

class _PowerConsumptionState extends State<PowerConsumption> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: height * 1.6 / 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: const GradientBoxBorder(
                  width: 3,
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(0, 255, 255, 255), Colors.white],
                    stops: [0.4, 0.7],
                    transform: GradientRotation(8.4),
                  ))),
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              "asset/spiral_background_3.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 120,
          margin: const EdgeInsets.only(left: 15, right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Energy",
                      style: TextStyle(
                          color: Color.fromARGB(227, 216, 216, 216),
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                    const Padding(padding: EdgeInsets.all(0.5)),
                    const Text(
                      "1 wh",
                      style: TextStyle(
                          color: Color.fromARGB(228, 255, 255, 255),
                          fontSize: 29,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.all(0.5)),
                    Text(
                      "${DataContainer.devicesData.length} Devices Turned On",
                      style: const TextStyle(
                          color: Color.fromARGB(239, 255, 255, 255),
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 140,
                  width: 80,
                  margin: const EdgeInsets.only(right: 20, top: 5),
                  padding: const EdgeInsets.all(20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(120)),
                  child: Image.asset("asset/flash.png"))
            ],
          ),
        ),
      ],
    );
  }
}
