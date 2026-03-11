import 'package:flutter/material.dart';
import 'package:roi_calculator/models/industry_type_model.dart';

class IndustryCard extends StatelessWidget {
  final IndustryType industry;
  final bool selected;
  final VoidCallback onTap;

  const IndustryCard({
    super.key,
    required this.industry,
    required this.selected,
    required this.onTap,
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
              Image.asset(
                industry.image,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/images/default.jpg",
                    height: 60,
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(industry.name, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
