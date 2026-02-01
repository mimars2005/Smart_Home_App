// ignore_for_file: unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:smart_home/presentation/screen/dashboard/Dashboard.dart';

class DropdownLabel extends StatelessWidget {
  const DropdownLabel({super.key,required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return GradientText(
                              label,
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                              gradient: const LinearGradient(
                                  transform: GradientRotation(1.55),
                                  colors: [
                                    const Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(205, 228, 228, 228),
                                  ],
                                  stops: [
                                    0.45,
                                    0.62,
                                  ]),
                            );
  }
}