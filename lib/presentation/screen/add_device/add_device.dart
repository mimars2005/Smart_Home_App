import 'package:flutter/material.dart';
import 'package:smart_home/domain/model/ble/ble_controller.dart';
import 'package:smart_home/presentation/screen/add_device/device_screen/device_screen.dart';
import 'package:smart_home/presentation/screen/add_device/scan_screen/scan_screen.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  PageController pageController = PageController(initialPage: 0);
  BLEController bleController = BLEController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
     await bleController.currentDevice.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        ScanScreen(
          bleController: bleController,
          pageController: pageController,
        ),
        DeviceScreen(
          pageController: pageController,
          bleController: bleController,
        )
      ],
    );
  }
}
