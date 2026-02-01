import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_home/data/repository/database_impl.dart';
import 'package:smart_home/data/static/dataContainer.dart';
import 'package:smart_home/domain/model/ble/ble_controller.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen(
      {super.key, required this.bleController, required this.pageController});

  final BLEController bleController;
  final PageController pageController;
  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  TextEditingController textController = TextEditingController();
  String data = "";
  bool inputVisible = false;

  DatabaseRepositoryImpl database = DatabaseRepositoryImpl();

  String getText(List<int> list) {
    String word = "";
    for (int letter in list) {
      word += String.fromCharCode(letter);
    }

    return word;
  }

  Future<void> writeData(String text) async {
    try {
      if (widget.bleController.currentDevice.isConnected) {
        var services =
            await widget.bleController.currentDevice.discoverServices();
        services[2].characteristics[0].write(text.codeUnits);
        await readData();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> readData() async {
    List<int> result = [];
    try {
      if (widget.bleController.currentDevice.isConnected) {
        var services =
            await widget.bleController.currentDevice.discoverServices();
        result = await services[2].characteristics[0].read();
        data = getText(result);
        Map<String, dynamic> jsonData = {};
        try {
          jsonData = json.decode(data.toString());
        } catch (e) {
          data = "Connecting to Wifi";
          inputVisible = false;
        }

        log(jsonData.length.toString());
        if (jsonData.length > 0) {
          if (jsonData.keys.first.toString().contains("wifi")) {
            data = "What's Wifi's name?";
            inputVisible = true;
          } else if (jsonData.keys.first.toString().contains("password")) {
            data = "What's the password?";
            inputVisible = true;
          } else if (jsonData.keys.first.toString().contains("room")) {
            data = "In which room am I?";
            log(jsonData[jsonData.keys.first.toString()].toString());
            inputVisible = true;
          } else if (jsonData.keys.first.toString().contains("MAC")) {
            data = "Set up successful";
            String MAC = jsonData[jsonData.keys.first.toString()].toString();
            String isServer =
                jsonData[jsonData.keys.elementAt(1).toString()].toString();
            String room =
                jsonData[jsonData.keys.elementAt(2).toString()].toString();
            String type = widget.bleController.currentDevice.advName
                .split(" ")[2]
                .toString()
                .toLowerCase();
            database.addDevice(DataContainer.username, DataContainer.password,
                type, room, MAC, isServer);
            inputVisible = false;

            log(DataContainer.username);
            log(DataContainer.password);
            log(type);
            log(room);
            log(MAC);
            log(isServer.contains("1").toString());
          }
        } else {
          data = "Connecting to Wifi";
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return getText(result);
  }

  @override
  void dispose() {
    widget.bleController.currentDevice.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readData(),
        builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            textController.text = "";
                            data = "";
                            await widget.bleController.currentDevice
                                .disconnect();
                            await widget.pageController.animateToPage(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Text(
                        "Device: ${widget.bleController.currentDevice != null ? widget.bleController.currentDevice.advName : "No device connected"}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                      opacity: snapshot.data != null ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        snapshot.data != null ? data : "",
                        style: const TextStyle(color: Colors.white),
                      )),
                  AnimatedOpacity(
                    opacity: snapshot.data != null && inputVisible ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          height: 50,
                          child: SearchBar(
                            controller: textController,
                            hintText: data.contains("name")
                                ? "Enter name"
                                : data.contains("password")
                                    ? "Enter password"
                                    : "",
                            trailing: [
                              IconButton(
                                  onPressed: () async {
                                    await writeData(textController.text);
                                    setState(() {
                                      textController.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.send))
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
