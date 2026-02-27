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
	final _formKey = GlobalKey<FormState>();

	double? _inputedTemperature;
	TemperatureScale?  _selectedInputScale;

	double? _convertedTemperature;
    TemperatureScale? _selectedConvertedScale;

    final List<TemperatureScale> _scalesOptions = [Celsius(), Fahrenheit(), Kelvin()];


    @override
    Widget build(BuildContext context) {
       return Form(
            key: _formKey,
            child: Column(
                children: [
                    TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Valor a ser convertido",
                            border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                            if (value == null || value.isEmpty){
                                return "Insira um valor";
                            }
                            if (double.tryParse(value) == null){
                                return "Apenas números são permitidos";
                            }
                            return null;
                        },
                        onSaved: (newValue) {
                            _inputedTemperature = double.parse(newValue!);
                        },
                    ),

                    const SizedBox(height: 20),
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            labelText: "Selecione a unidade de medida a ser convertida"
                        ),
                        initialValue: _scalesOptions[0],
                        items: _scalesOptions
                            .map((option) => DropdownMenuItem(
                                value: option,
                                child: Text(option.getName),
                            ))
                            .toList(),
                        onChanged: (value) {
                            setState(() {
                                _selectedInputScale = value;
                            });
                        },
                        validator: (value) => 
                            value == null ? "Selecione uma opção" : null,
                    ),
                ],
            )
       );
    }
}
