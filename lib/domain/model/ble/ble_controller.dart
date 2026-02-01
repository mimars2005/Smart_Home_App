import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEController {
  FlutterBluePlus ble = FlutterBluePlus();
  List<BluetoothDevice> devices = [];

  late BluetoothDevice currentDevice;

  Future<void> scanDevices() async {
    if(await Permission.location.request().isGranted)
    {
    if (await Permission.bluetooth.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        if(await Permission.bluetoothScan.request().isGranted)
        {
          await FlutterBluePlus.startScan(timeout:  const Duration(seconds: 15));
        }
      }
    }
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect(timeout: const Duration(seconds: 15));
  }

  bool checkIfContainsDevice(String deviceName) {
    for (var device in devices) {
      if (device.advName == deviceName) {
        return true;
      }
    }
    return false;
  }


  Stream<List<ScanResult>> get scanResult => FlutterBluePlus.scanResults;
}
