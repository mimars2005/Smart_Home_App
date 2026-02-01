import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_home/data/static/dataContainer.dart';
import 'package:smart_home/domain/model/device.dart';
import 'package:smart_home/domain/model/room.dart';
import 'package:smart_home/domain/repository/database.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  static DatabaseRepositoryImpl? instance;

  DatabaseRepositoryImpl._internal();

  static late String _url;

  factory DatabaseRepositoryImpl() {
    instance ??= DatabaseRepositoryImpl._internal();
    _url = dotenv.env['SERVER_URL']!;
    return instance!;
  }

  final Dio dio = Dio();

  @override
  Future<Room> findDevice() {
    // TODO: implement findDevice
    throw UnimplementedError();
  }

  @override
  Future<bool> getDeviceState() {
    // TODO: implement getDeviceState
    throw UnimplementedError();
  }

  @override
  Future<bool> getDeviceType() {
    // TODO: implement getDeviceType
    throw UnimplementedError();
  }

  @override
  Future<bool> getDeviceValue() {
    // TODO: implement getDeviceValue
    throw UnimplementedError();
  }

  @override
  Future<bool> getFullHouseConsumption() {
    // TODO: implement getFullHouseConsumption
    throw UnimplementedError();
  }

  @override
  Future<void> getHome() {
    // TODO: implement getHome
    throw UnimplementedError();
  }

  bool checkIfRoomExists(String newRoom) {
    for (var room in DataContainer.rooms) {
      if (room.name == newRoom) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> getRooms(String username, String password) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\"}";
    var data = await dio.post("$_url/get_rooms.php", data: jsonToSend);
    try {
      var jsonData = json.decode(data.data.toString());
      DataContainer.rooms.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Room room = Room();
        room.name = jsonData[i]["room"].toString();
        if (!checkIfRoomExists(room.name)) {
          DataContainer.rooms.add(room);
        }
      }
    } catch (ex) {
      log(ex.toString());
    }
  }

  @override
  Future<void> getServer() {
    // TODO: implement getServer
    throw UnimplementedError();
  }

  @override
  Future<bool> ifContainsDevice() {
    // TODO: implement ifContainsDevice
    throw UnimplementedError();
  }

  @override
  Future<bool> ifContainsRoom() {
    // TODO: implement ifContainsRoom
    throw UnimplementedError();
  }

  bool checkIfContainerContainsDevice(Device newDevice) {
    for (int i = 0; i < DataContainer.devices.length; i++) {
      if (DataContainer.devices[i].id == newDevice.id) {
        DataContainer.devices[i].room = newDevice.room;
        DataContainer.devices[i].type = newDevice.type;
        DataContainer.devices[i].state = newDevice.state;
        DataContainer.devices[i].value = newDevice.value;
        DataContainer.devices[i].voltage = newDevice.voltage;
        return true;
      }
    }
    return false;
  }

  @override
  Future<dynamic> getDevices(String username, String password) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\"}";
    var data = await dio.post("$_url/get_devices.php", data: jsonToSend);
    try {
      var jsonData = json.decode(data.data.toString());
      DataContainer.devices.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Device device = Device();
        device.id = int.parse(jsonData[i]["id"].toString());
        device.type = jsonData[i]["type"].toString();
        device.state = jsonData[i]["state"].toString() == "1" ? true : false;
        device.value = double.parse(jsonData[i]["value"].toString());
        device.MAC = jsonData[i]["MAC"].toString();

        if (!checkIfContainerContainsDevice(device)) {
          DataContainer.devices.add(device);
        }
      }
    } catch (ex) {
      log(ex.toString());
    }

    return null;
  }

  @override
  Future<dynamic> getDevicesCount(String username, String password) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\"}";
    var data = await dio.post("$_url/get_devices_count.php", data: jsonToSend);
    try {
      var jsonData = json.decode(data.data.toString());
      DataContainer.devicesData.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Device device = Device();
        device.type = jsonData[i]["type"];
        DataContainer.devicesData.addAll({
          i: {device: int.parse(jsonData[i]["count"].toString())}
        });
      }
    } catch (ex) {
      log(ex.toString());
    }

    return null;
  }

  @override
  Future<void> changeDeviceState(
      int deviceId, bool newState, String username, String password) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\",\"device_id\": \"$deviceId\",\"new_state\": \"${newState ? 1 : 0}\"}";
    log(jsonToSend);
    var data =
        await dio.post("$_url/change_device_state.php", data: jsonToSend);
    log(data.data.toString());
  }

  @override
  Future getDevicesInRoom(String username, String password, String room) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\",\"room\": \"${room.toLowerCase()}\"}";
    var data =
        await dio.post("$_url/get_devices_in_room.php", data: jsonToSend);
    try {
      var jsonData = json.decode(data.data.toString());
      DataContainer.devices.clear();
      for (int i = 0; i < jsonData.length; i++) {
        Device device = Device();
        device.id = int.parse(jsonData[i]["id"].toString());
        device.type = jsonData[i]["type"].toString();
        device.state = jsonData[i]["state"].toString() == "1" ? true : false;
        device.MAC = jsonData[i]["MAC"].toString();

        if (!checkIfContainerContainsDevice(device)) {
          DataContainer.devices.add(device);
        }
      }
    } catch (ex) {
      log(ex.toString());
    }

    return null;
  }

  @override
  Future<void> addDevice(String username, String password, String type,
      String room, String MAC, String isServer) async {
    String jsonToSend =
        "{\"account_username\": \"$username\",\"account_password\": \"${sha256.convert(utf8.encode(password))}\",\"room\": \"${room}\",\"type\": \"${type}\",\"MAC\": \"${MAC}\",\"is_server\": \"${isServer}\"}";
    var data = await dio.post("$_url/add_device.php", data: jsonToSend);
    log(data.data.toString());
  }
}
