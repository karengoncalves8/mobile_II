import 'package:temperature_converter/models/temperature_scale.dart';

class Fahrenheit extends TemperatureScale {
  Fahrenheit() : super("Fahrenheit", "°F");

  double toCelsius(double value) {
    return (value - 32) * 5 / 9;
  }

  double toKelvin(double value) {
    return (value - 32) * 5 / 9 + 273;
  }
}
