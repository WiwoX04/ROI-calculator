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

        Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.blue,
              selectionColor: Color(0x553219FF), // półprzezroczysty niebieski
              selectionHandleColor: Colors.blue,
            ),
          ),
          child: TextField(
            controller: _controller,
            cursorColor: Colors.blue,

            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              // Pozwala na liczby ułamkowe
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            decoration: InputDecoration(
              suffixText: widget.suffix,
              suffixStyle: const TextStyle(
                color: Color(0xFF94A3B8), // kolor "zł"
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFE2E8F0), // Twój kolor
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
              ),
            ),

            onChanged: (value) {
              // Zamiana przecinka na kropkę w razie użycia lokalnej klawiatury
              final normalizedValue = value.replaceAll(',', '.');
              widget.onChanged(double.tryParse(normalizedValue) ?? 0);
            },
          ),
        ),
      ],
    );
  }
}
