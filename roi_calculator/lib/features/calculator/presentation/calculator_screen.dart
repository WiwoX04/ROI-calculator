import 'package:flutter/material.dart';
import 'package:roi_calculator/features/calculator/logic/calculator_logic.dart';
import 'package:roi_calculator/features/calculator/presentation/number_input.dart';
import 'package:roi_calculator/features/calculator/presentation/section_card.dart';
import 'package:roi_calculator/models/calculator_state.dart';
import 'package:go_router/go_router.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  CalculatorState state = CalculatorState();

  @override
  Widget build(BuildContext context) {
    final roi = RoiCalculator.roi(state);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.calculate, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 8),
            const Text(
              'Wholesale Roi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SectionCard(
              child: NumberInput(
                label: "Roczny obrót(PLN)",
                suffix: "zł",
                value: state.yearlyRevenue,
                onChanged: (v) => setState(() => state.yearlyRevenue = v),
              ),
            ),
            const SizedBox(height: 20),
            SectionCard(
              child: NumberInput(
                label: "Średnia wartość zamówienia",
                suffix: "zł",
                value: state.avgOrderValue,
                onChanged: (v) => setState(() => state.avgOrderValue = v),
              ),
            ),
            const SizedBox(height: 20),
            SectionCard(
              child: Text(
                "${roi.toStringAsFixed(1)} %",
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                context.go('/insights');
              },
              child: const Text("Policz ROI i generuj raport"),
            ),
          ],
        ),
      ),
    );
  }
}
