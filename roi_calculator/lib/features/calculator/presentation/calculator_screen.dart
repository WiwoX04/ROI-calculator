import 'package:flutter/material.dart';
import 'package:roi_calculator/features/calculator/logic/calculator_logic.dart';
import 'package:roi_calculator/features/calculator/presentation/cost_selection_card.dart';
import 'package:roi_calculator/features/calculator/presentation/number_input.dart';
import 'package:roi_calculator/features/calculator/presentation/percentage_input.dart';
import 'package:roi_calculator/features/calculator/presentation/section_card.dart';
import 'package:roi_calculator/features/calculator/presentation/silder_input.dart';
import 'package:roi_calculator/models/calculator_state.dart';
import 'package:go_router/go_router.dart';

class CalculatorScreen extends StatefulWidget {
  final selectedIndustry;
  const CalculatorScreen({super.key, required this.selectedIndustry});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  CalculatorState state = CalculatorState();

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  PercentageInput(
                    label: "telefon",
                    value: state.phoneShare,
                    onChanged: (v) => setState(() => state.phoneShare = v),
                  ),
                  PercentageInput(
                    label: "mail/sms",
                    value: state.mailShare,
                    onChanged: (v) => setState(() => state.mailShare = v),
                  ),
                  PercentageInput(
                    label: "osobiste",
                    value: state.inPersonShare,
                    onChanged: (v) => setState(() => state.inPersonShare = v),
                  ),
                  PercentageInput(
                    label: "e-commerce",
                    value: state.phoneShare,
                    onChanged: (v) => setState(() => state.ecommerceShare = v),
                  ),
                ],
              ),
            ),
            SectionCard(
              child: Column(
                children: [
                  PercentageInput(
                    label: "z kanału Telefon",
                    value: state.phoneShare,
                    onChanged: (v) => setState(() => state.phoneMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału mail/sms",
                    value: state.mailShare,
                    onChanged: (v) => setState(() => state.mailMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału osobiste",
                    value: state.inPersonShare,
                    onChanged:
                        (v) => setState(() => state.personalMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału e-commerce",
                    value: state.phoneShare,
                    onChanged:
                        (v) => setState(() => state.ecommerceMigration = v),
                  ),
                ],
              ),
            ),
            CostSelectionCard(
              name: "Telefon",
              cost: state.phoneCost,
              selected: state.selectedChannel == "Phone",
              onTap: () => setState(() => state.selectedChannel = "Phone"),
            ),
            CostSelectionCard(
              name: "Mail/SMS",
              cost: state.mailCost,
              selected: state.selectedChannel == "Mail",
              onTap: () => setState(() => state.selectedChannel = "Mail"),
            ),
            CostSelectionCard(
              name: "Osobiste",
              cost: state.inPersonCost,
              selected: state.selectedChannel == "Personal",
              onTap: () => setState(() => state.selectedChannel = "Personal"),
            ),
            CostSelectionCard(
              name: "Aplikacja",
              cost: state.mobileCost,
              selected: state.selectedChannel == "Mobile",
              onTap: () => setState(() => state.selectedChannel = "Mobile"),
            ),
            SizedBox(height: 20),
            SectionCard(
              child: PercentageInput(
                label: "% pomyłek (kanały tradycyjne)",
                value: state.errorRate,
                onChanged: (v) => setState(() => state.errorRate = v),
              ),
            ),
            SizedBox(height: 20),
            SectionCard(
              child: NumberInput(
                label: "koszt jednej pomyłki",
                suffix: "zł",
                value: state.errorCost,
                onChanged: (v) => setState(() => state.errorCost = v),
              ),
            ),
            SectionCard(
              child: Column(
                children: [
                  SliderInput(
                    label: "CAPEX (Wdrożenie)",
                    value: state.capex,
                    onChanged: (v) => setState(() => state.capex = v),
                    min: 80000,
                    max: 200000,
                    suffix: "zł",
                  ),
                  SizedBox(height: 20),
                  SliderInput(
                    label: "OPEX (Utrzymanie mies.)",
                    value: state.opex,
                    onChanged: (v) => setState(() => state.opex = v),
                    min: 10000,
                    max: 50000,
                    suffix: "zł",
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final result = RoiCalculator.calculateResult(state);

                final url =
                    '/results'
                    '?roi=${result.roi}'
                    '&benefit=${result.benefit}'
                    '&cost=${result.cost}'
                    '&orders=${result.yearlyOrders}'
                    '&esavings=${result.errorSavings}'
                    '&msavings=${result.migrationSavings}'
                    '&selectedIndustry=${widget.selectedIndustry}'
                    '&profit=${result.salesGrowthProfit}';

                context.go(url);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF), // Jaskrawy niebieski
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.rocket_launch_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Policz ROI i generuj raport",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // 6. Drobny tekst pod przyciskiem
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Wszystkie dane zostaną zapisane automatycznie',
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // 7. Stopka
            const Text(
              '© 2024 Wholesale ROI Calculator. Wszystkie prawa\nzastrzeżone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
