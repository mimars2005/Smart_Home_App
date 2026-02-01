import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Device extends StatelessWidget {
  const Device(
      {super.key,
      required this.name,
      required this.icon,
      required this.count,
      required this.width});
  final String name;
  final Widget icon;
  final int count;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(colors: [
           Color.fromARGB(255, 254, 244, 244),
            Color.fromARGB(255, 255, 255, 255),
             Color.fromARGB(255, 255, 255, 255),
           Color.fromARGB(255, 255, 255, 255)
          ], stops: [
            0.1,
            0.3,
            0.7,
            0.9
          ]),
          boxShadow: const [BoxShadow(
            blurRadius: 3,
            color: Color.fromARGB(137, 152, 152, 152),
            offset: Offset(0,3)
          )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            Align(
              child: Container(
                // ignore: unnecessary_this
                child: this.icon,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                  color: Color.fromARGB(239, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "x$count Devices",
                style: const TextStyle(
                    color: Color.fromARGB(246, 51, 50, 50), fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
