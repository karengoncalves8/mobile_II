import 'package:temperature_converter/models/temperature_scale.dart';

class Kelvin extends TemperatureScale{

    Kelvin() : super("Kelvin", "K");

    double toFahrenheit(int value){
        return (value - 273) * 1.8 + 32;
    }

    double toCelsius(int value){
        return value - 273;
    }
}