import 'package:temperature_converter/models/temperature_scale.dart';

class Celsius extends TemperatureScale {
  Celsius() : super("Celsius", "°C");

  double toFahrenheit(double value) {
    return (value * 1.8) + 32;
  }

  double toKelvin(double value) {
    return value + 273;
  }
}
