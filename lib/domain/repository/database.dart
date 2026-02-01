import 'package:smart_home/domain/model/room.dart';
import 'package:smart_home/presentation/screen/add_device/add_device.dart';

abstract class DatabaseRepository {
  Future<void> addDevice(String username, String password, String type,
      String room, String MAC, String isServer);
  Future<dynamic> getDevices(String username, String password);
  Future<void> getRooms(String username, String password);
  Future<void> getServer();
  Future<void> getHome();
  Future<bool> ifContainsDevice();
  Future<bool> ifContainsRoom();
  Future<Room> findDevice();
  Future<bool> getFullHouseConsumption();
  Future<dynamic> getDevicesInRoom(
      String username, String password, String room);
  Future<dynamic> getDevicesCount(String username, String password);
  Future<bool> getDeviceState();
  Future<bool> getDeviceValue();
  Future<bool> getDeviceType();
  Future<void> changeDeviceState(
      int deviceId, bool newState, String username, String password);
}
