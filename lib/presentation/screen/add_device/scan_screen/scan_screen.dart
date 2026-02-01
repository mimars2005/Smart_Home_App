import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:smart_home/domain/model/ble/ble_controller.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen(
      {super.key, required this.pageController, required this.bleController});

  final PageController pageController;
  final BLEController bleController;
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.bleController.scanDevices(),
        builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder(
              stream: widget.bleController.scanResult,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  for (int i = 0; i < snapshot.data!.length; i++) {
                    if (snapshot.data![i].device.advName != "") {
                      if (!widget.bleController.checkIfContainsDevice(
                          snapshot.data![i].device.advName)) {
                        widget.bleController.devices
                            .add(snapshot.data![i].device);
                      }
                    }
                  }
                }

                return ListView.builder(
                  itemCount: widget.bleController.devices.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent)),
                        onPressed: () async {
                          await FlutterBluePlus.stopScan();
                          widget.bleController.currentDevice =
                              widget.bleController.devices[index];
                          await widget.bleController.connectToDevice(
                              widget.bleController.devices[index]);
                    
                          await widget.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        },
                        child: Text(
                          widget.bleController.devices[index].advName
                              .toString(),
                          style:
                              const TextStyle(color: Colors.white, fontSize: 20),
                        ));
                  },
                );
              },
            ),
          );
        });
  }
}
