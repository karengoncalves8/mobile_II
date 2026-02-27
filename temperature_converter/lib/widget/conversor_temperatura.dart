import 'package:flutter/material.dart';
import 'package:temperature_converter/models/celsius.dart';
import 'package:temperature_converter/models/fahrenheit.dart';
import 'package:temperature_converter/models/kelvin.dart';
import 'package:temperature_converter/models/temperature_scale.dart';

class ConversorTemperatura extends StatefulWidget {
  const ConversorTemperatura({super.key});

  @override
  State<ConversorTemperatura> createState() => _ConversorTemperaturaState();
}

class _ConversorTemperaturaState extends State<ConversorTemperatura> {
  final celsius = Celsius();
  final fahrenheit = Fahrenheit();
  final kelvin = Kelvin();

  final _formKey = GlobalKey<FormState>();

  double? _inputedTemperature;
  late TemperatureScale _selectedInputScale;

  double? _convertedTemperature;
  late TemperatureScale _selectedConvertedScale;

  late final List<TemperatureScale> _scalesOptions;

  @override
  void initState() {
    super.initState();
    _scalesOptions = [celsius, fahrenheit, kelvin];
    _selectedInputScale = celsius;
    _selectedConvertedScale = fahrenheit;
  }

  void _convertTemperature() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var convertedTemperature = 0.0;
      switch (_selectedInputScale.getName) {
        case "Celsius":
          if (_selectedConvertedScale is Fahrenheit) {
            convertedTemperature = (_selectedInputScale as Celsius)
                .toFahrenheit(_inputedTemperature!);
          } else if (_selectedConvertedScale is Kelvin) {
            convertedTemperature = (_selectedInputScale as Celsius).toKelvin(
              _inputedTemperature!,
            );
          }
          break;
        case "Fahrenheit":
          if (_selectedConvertedScale is Celsius) {
            convertedTemperature = (_selectedInputScale as Fahrenheit)
                .toCelsius(_inputedTemperature!);
          } else if (_selectedConvertedScale is Kelvin) {
            convertedTemperature = (_selectedInputScale as Fahrenheit).toKelvin(
              _inputedTemperature!,
            );
          }
          break;
        case "Kelvin":
          if (_selectedConvertedScale is Celsius) {
            convertedTemperature = (_selectedInputScale as Kelvin).toCelsius(
              _inputedTemperature!,
            );
          } else if (_selectedConvertedScale is Fahrenheit) {
            convertedTemperature = (_selectedInputScale as Kelvin).toFahrenheit(
              _inputedTemperature!,
            );
          }
          break;
      }

      setState(() {
        _convertedTemperature = convertedTemperature;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Valor a ser convertido",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Insira um valor";
                  }
                  if (double.tryParse(value) == null) {
                    return "Apenas números são permitidos";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _inputedTemperature = double.parse(newValue!);
                },
              ),

              const SizedBox(height: 20),
              DropdownButtonFormField<TemperatureScale>(
                decoration: const InputDecoration(
                  labelText: "Selecione a unidade de medida a ser convertida",
                ),
                initialValue: _selectedInputScale,
                items: _scalesOptions
                    .map(
                      (option) => DropdownMenuItem(
                        value: option,
                        child: Text(option.getName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _selectedInputScale = value;
                      _convertedTemperature = null;
                    }
                  });
                  _formKey.currentState?.validate();
                },
                validator: (value) {
                  if (value == null) {
                    return "Selecione uma opção";
                  }
                  if (value.getName == _selectedConvertedScale.getName) {
                    return "A unidade de medida deve ser diferente da unidade de conversão";
                  }
                  return null;
                },
              ),

              Icon(
                Icons.swap_horiz,
                color: Colors.lightBlue,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),

              const SizedBox(height: 20),
              DropdownButtonFormField<TemperatureScale>(
                decoration: const InputDecoration(
                  labelText: "Selecione a unidade a desejada",
                ),
                initialValue: _selectedConvertedScale,
                items: _scalesOptions
                    .map(
                      (option) => DropdownMenuItem(
                        value: option,
                        child: Text(option.getName),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      _selectedConvertedScale = value;
                      _convertedTemperature = null;
                    }
                  });
                  _formKey.currentState?.validate();
                },
                validator: (value) {
                  if (value == null) {
                    return "Selecione uma opção";
                  }
                  if (value.getName == _selectedInputScale.getName) {
                    return "A unidade de medida deve ser diferente da unidade de conversão";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _convertTemperature,
                child: const Text("Converter"),
              ),
            ],
          ),

          const SizedBox(height: 20),
          if (_convertedTemperature != null)
            Text(
              "Resultado: ${_convertedTemperature!.toStringAsFixed(2)} ${_selectedConvertedScale.getSuffix}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
