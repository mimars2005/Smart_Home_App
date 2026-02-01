import 'package:smart_home/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getForecast();
}
