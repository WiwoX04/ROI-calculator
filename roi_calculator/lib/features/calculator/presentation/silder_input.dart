import 'package:flutter/material.dart';

class SliderInput extends StatefulWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int? divisions; // Opcjonalne: "kroki" suwaka
  final String suffix;
  final Function(double) onChanged;

  const SliderInput({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.divisions,
    this.suffix = "",
  });

  @override
  State<SliderInput> createState() => _SliderInputState();
}

class _SliderInputState extends State<SliderInput> {
  // Używamy zmiennej lokalnej dla płynności animacji suwaka
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant SliderInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Jeśli wartość zmieni się z zewnątrz, aktualizujemy stan lokalny
    if (oldWidget.value != widget.value) {
      setState(() {
        _currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nagłówek: Etykieta i aktualna wartość
        SizedBox(
          child: Column(
            children: [
              Text(
                widget.label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                "${_currentValue.toStringAsFixed(1)}${widget.suffix}",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Suwak
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            thumbColor: Colors.blue,
            activeTrackColor: Colors.blue,
          ),
          child: Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            divisions: widget.divisions,
            label: _currentValue.toStringAsFixed(1), // Dymek nad suwakiem
            onChanged: (newValue) {
              setState(() {
                _currentValue = newValue;
              });
              widget.onChanged(newValue);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.min / 1000}K",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
            Text(
              "${widget.max / 1000}K",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ],
    );
  }
}
