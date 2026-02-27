import 'package:temperature_converter/models/temperature_scale.dart';

class Celsius extends TemperatureScale{

    Celsius() : super("Celsius", "°C");

    double toFahrenheit(int value) {
      return (value * 1.8) + 32;
    }

    double toKelvin(int value) {
      return value + 273;
    }
}
