import 'package:flutter/material.dart';

class CostSelectionCard extends StatelessWidget {
  final String name;
  final double cost;
  final bool selected;
  final VoidCallback onTap;
  final String label;

  const CostSelectionCard({
    super.key,
    required this.name,
    required this.cost,
    required this.selected,
    required this.onTap,
    this.label = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Card(
        color: selected ? Colors.blue.shade50 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selected ? Colors.blue : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(name, textAlign: TextAlign.left),
              Text(name, textAlign: TextAlign.left),
            ],
          ),
        ),
      ),
    );
  }
}
