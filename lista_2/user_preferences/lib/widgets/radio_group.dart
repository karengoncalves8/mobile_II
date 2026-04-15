import 'package:flutter/material.dart';

class RadioGroupOption {
  final String value;
  final String label;

  const RadioGroupOption({required this.value, required this.label});
}

class CustomRadioGroup extends StatelessWidget {
  final String title;
  final List<RadioGroupOption> options;
  final String selectedOption;
  final ValueChanged<String?> onChanged;

  const CustomRadioGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),

        RadioGroup(
          onChanged: onChanged,
          groupValue: selectedOption,
          child: Row(
            children: [
              ...options.map(
                (option) => Expanded(
                  child: RadioListTile<String>(
                    title: Text(option.label),
                    value: option.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
