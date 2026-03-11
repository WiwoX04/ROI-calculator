import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  final String label;
  final String suffix;
  final double value;
  final Function(double) onChanged;

  const NumberInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.suffix = "",
  });

  @override
  Widget build(BuildContext context) {
    final controller =
        TextEditingController(text: value.toStringAsFixed(0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            suffixText: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            onChanged(double.tryParse(value) ?? 0);
          },
        ),
      ],
    );
  }
}