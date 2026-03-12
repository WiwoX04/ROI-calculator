import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInput extends StatefulWidget {
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
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;

  String _formatValue(double val) {
    return val == val.truncateToDouble()
        ? val.toStringAsFixed(0)
        : val.toString();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatValue(widget.value));
  }

  @override
  void didUpdateWidget(covariant NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      double currentParsed = double.tryParse(_controller.text) ?? 0;
      if (currentParsed != widget.value) {
        _controller.text = _formatValue(widget.value);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          inputFormatters: [
            // Pozwala na liczby ułamkowe
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          decoration: InputDecoration(
            suffixText: widget.suffix,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onChanged: (value) {
            // Zamiana przecinka na kropkę w razie użycia lokalnej klawiatury
            final normalizedValue = value.replaceAll(',', '.');
            widget.onChanged(double.tryParse(normalizedValue) ?? 0);
          },
        ),
      ],
    );
  }
}
