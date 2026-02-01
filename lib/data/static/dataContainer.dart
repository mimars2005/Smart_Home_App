import 'package:smart_home/domain/model/device.dart';
import 'package:smart_home/domain/model/room.dart';

class DataContainer {
  static Map<int, Map<Device, int>> devicesData = {};
  static String username="";
  static String password="";
  static List<Device> devices=[];
  static List<Room> rooms=[];
  static String selectedRoom="All";
}
