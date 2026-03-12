import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PercentageInput extends StatefulWidget {
  final String label;
  final double value;
  final Function(double) onChanged;

  const PercentageInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<PercentageInput> createState() => _PercentageInputState();
}

class _PercentageInputState extends State<PercentageInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toStringAsFixed(0));
  }

  @override
  void didUpdateWidget(covariant PercentageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValueString = widget.value.toStringAsFixed(0);
    if (oldWidget.value != widget.value && _controller.text != newValueString) {
      _controller.text = newValueString;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChange(String value) {
    if (value.isEmpty) {
      widget.onChanged(0);
      return;
    }

    double parsedValue = double.tryParse(value) ?? 0;

    if (parsedValue > 100) {
      parsedValue = 100;
      _controller.text = '100';
      _controller.selection = TextSelection.fromPosition(
        const TextPosition(offset: 3),
      );
    }

    widget.onChanged(parsedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 6),
        TextField(
          controller: _controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            suffixText: "%",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: _handleChange,
        ),
      ],
    );
  }
}
