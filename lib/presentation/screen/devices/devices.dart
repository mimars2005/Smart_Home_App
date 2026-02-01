import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/data/repository/database_impl.dart';
import 'package:smart_home/data/static/dataContainer.dart';
import 'package:smart_home/data/static/globals.dart';
import 'package:smart_home/presentation/screen/background.dart';
import 'package:smart_home/presentation/screen/devices/widgets/custom_dropdown_label.dart';
import 'package:smart_home/presentation/screen/devices/widgets/device_gradiented.dart';
import 'package:smart_home/presentation/screen/devices/widgets/device_list.dart';

bool isGrid = true;

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({
    super.key,
    required this.pageController,
    required this.method,
    required this.showAddDevice,
  });
  final VoidCallback method;
  final VoidCallback showAddDevice;

  final PageController pageController;
  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  void InvertGrid() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  List<DropdownMenuItem> convertListIntoDropDownMenu() {
    List<DropdownMenuItem> items = [
      const DropdownMenuItem(
        value: "All",
        child: DropdownLabel(
          label: "All",
        ),
      )
    ];
    for (var room in DataContainer.rooms) {
      if (!items.contains(DropdownMenuItem(
        value: room.name,
        child: DropdownLabel(
          label: room.name,
        ),
      ))) {
        items.add(DropdownMenuItem(
          value: room.name,
          child: DropdownLabel(
            label: room.name,
          ),
        ));
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    DatabaseRepositoryImpl database = DatabaseRepositoryImpl();

    Future<void> getDevices() async {
      if (DataContainer.selectedRoom == "All") {
        await database.getDevices(
            DataContainer.username, DataContainer.password);
      } else {
        await database.getDevicesInRoom(DataContainer.username,
            DataContainer.password, DataContainer.selectedRoom);
      }
      await database.getRooms(DataContainer.username, DataContainer.password);
    }

    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 10)),
      builder: (context, snapshot) {
        return Stack(
          children: [
            const Background(),
            FutureBuilder(
              future: getDevices(),
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: height * 0.7 / 10,
                                width: height * 0.7 / 10,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 97, 192, 174),
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  onPressed: () async {
                                    Globals.navItemClicked = 0;
                                    widget.pageController.animateToPage(0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut);
                                    widget.method.call();
                                  },
                                ),
                              ),
                              const Padding(padding: EdgeInsets.all(15)),
                              DropdownButton2(
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      transform: GradientRotation(1.5),
                                      colors: [
                                        Colors.white,
                                        Color.fromARGB(197, 180, 207, 215),
                                      ],
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        color:
                                            Color.fromARGB(197, 180, 207, 215),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(17),
                                    color:
                                        const Color.fromARGB(47, 255, 255, 255),
                                  ),
                                ),
                                alignment: Alignment.center,
                                iconStyleData: const IconStyleData(iconSize: 0),
                                underline: const SizedBox(),
                                value: DataContainer.selectedRoom,
                                items: convertListIntoDropDownMenu(),
                                onChanged: (value) {
                                  if (value != null) {
                                    if (value == "All") {
                                      database.getDevices(
                                          DataContainer.username,
                                          DataContainer.password);
                                    } else {
                                      database.getDevicesInRoom(
                                          DataContainer.username,
                                          DataContainer.password,
                                          value);
                                    }
                                    setState(() {
                                      DataContainer.selectedRoom = value;
                                    });
                                  }
                                },
                              ),
                              const Padding(padding: EdgeInsets.all(15)),
                              Container(
                                height: height * 0.7 / 10,
                                width: height * 0.7 / 10,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 97, 192, 174),
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                child: IconButton(
                                  style: ButtonStyle(
                                    overlayColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => Colors.transparent,
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.showAddDevice.call();
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 30),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemCount: DataContainer.devices.length,
                              itemBuilder: (BuildContext context, int index) {
                                log((DataContainer.devices[index].type));
                                Widget image = const Icon(Icons.device_unknown);
                                switch (DataContainer.devices[index].type
                                    .toString()) {
                                  case "thermostat":
                                    image = Image.asset(
                                      "asset/thermostat.png",
                                      scale: 7,
                                      color: const Color.fromARGB(
                                          255, 123, 154, 233),
                                    );
                                    break;
                                  case "fire alarm":
                                    image = Image.asset(
                                      "asset/fire_alarm.png",
                                      scale: 7,
                                      color: const Color.fromARGB(
                                          255, 123, 154, 233),
                                    );
                                }

                                return DeviceUngradient(
                                  deviceId: DataContainer.devices[index].id,
                                  state: (DataContainer.devices[index].state),
                                  fromTime: "0hr 15min",
                                  name: ((DataContainer.devices[index].type)),
                                  value: ((DataContainer.devices[index].value)),
                                  image: image,
                                  method: InvertGrid,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
