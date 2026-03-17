import 'package:flutter/material.dart';
import 'package:roi_calculator/features/calculator/logic/calculator_logic.dart';
import 'package:roi_calculator/features/calculator/presentation/cost_selection_card.dart';
import 'package:roi_calculator/features/calculator/presentation/number_input.dart';
import 'package:roi_calculator/features/calculator/presentation/percentage_input.dart';
import 'package:roi_calculator/features/calculator/presentation/section_card.dart';
import 'package:roi_calculator/features/calculator/presentation/silder_input.dart';
import 'package:roi_calculator/features/calculator/presentation/tittle_widget.dart';
import 'package:roi_calculator/models/calculator_state.dart';
import 'package:go_router/go_router.dart';

class CalculatorScreen extends StatefulWidget {
  final selectedIndustry;
  final double? yearlyRevenue;
  final double? avgOrderValue;

  final double? phoneShare;
  final double? mailShare;
  final double? inPersonShare;
  final double? ecommerceShare;

  final double? phoneCost;
  final double? mailCost;
  final double? inPersonCost;
  final double? ecommerceCost;
  final double? mobileCost;
  final double? phoneMigration;
  final double? mailMigration;
  final double? personalMigration;
  final double? ecommerceMigration;

  final double? salesGrowth;
  final double? grossMargin;

  final double? errorRate;
  final double? ecommerceRate;
  final double? errorCost;

  final double? capex;
  final double? opex;

  const CalculatorScreen({
    super.key,
    required this.selectedIndustry,

    this.yearlyRevenue,
    this.avgOrderValue,

    this.phoneShare,
    this.mailShare,
    this.inPersonShare,
    this.ecommerceShare,

    this.phoneCost,
    this.mailCost,
    this.inPersonCost,
    this.ecommerceCost,
    this.mobileCost,

    this.phoneMigration,
    this.mailMigration,
    this.personalMigration,
    this.ecommerceMigration,

    this.salesGrowth,
    this.grossMargin,

    this.errorRate,
    this.ecommerceRate,
    this.errorCost,

    this.capex,
    this.opex,
  });

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double get totalShare =>
      state.phoneShare +
      state.mailShare +
      state.inPersonShare +
      state.ecommerceShare;

  bool get isShareValid => totalShare <= 100;
  CalculatorState state = CalculatorState();
  @override
  void initState() {
    super.initState();
    if (widget.yearlyRevenue != null) {
      state.yearlyRevenue = widget.yearlyRevenue ?? state.yearlyRevenue;
    }

    if (widget.avgOrderValue != null) {
      state.avgOrderValue = widget.avgOrderValue ?? state.avgOrderValue;
    }

    if (widget.phoneShare != null) {
      state.phoneShare = widget.phoneShare ?? state.phoneShare;
    }

    if (widget.mailShare != null) {
      state.mailShare = widget.mailShare ?? state.mailShare;
    }

    if (widget.inPersonShare != null) {
      state.inPersonShare = widget.inPersonShare ?? state.inPersonShare;
    }

    if (widget.ecommerceShare != null) {
      state.ecommerceShare = widget.ecommerceShare ?? state.ecommerceShare;
    }

    if (widget.phoneCost != null) {
      state.phoneCost = widget.phoneCost ?? state.phoneCost;
    }

    if (widget.mailCost != null) {
      state.mailCost = widget.mailCost ?? state.mailCost;
    }

    if (widget.inPersonCost != null) {
      state.inPersonCost = widget.inPersonCost ?? state.inPersonCost;
    }

    if (widget.ecommerceCost != null) {
      state.ecommerceCost = widget.ecommerceCost ?? state.ecommerceCost;
    }

    if (widget.mobileCost != null) {
      state.mobileCost = widget.mobileCost ?? state.mobileCost;
    }

    if (widget.phoneMigration != null) {
      state.phoneMigration = widget.phoneMigration ?? state.phoneMigration;
    }

    if (widget.mailMigration != null) {
      state.mailMigration = widget.mailMigration ?? state.mailMigration;
    }

    if (widget.personalMigration != null) {
      state.personalMigration =
          widget.personalMigration ?? state.personalMigration;
    }

    if (widget.ecommerceMigration != null) {
      state.ecommerceMigration =
          widget.ecommerceMigration ?? state.ecommerceMigration;
    }

    if (widget.salesGrowth != null) {
      state.salesGrowth = widget.salesGrowth ?? state.salesGrowth;
    }

    if (widget.grossMargin != null) {
      state.grossMargin = widget.grossMargin ?? state.grossMargin;
    }

    if (widget.errorRate != null) {
      state.errorRate = widget.errorRate ?? state.errorRate;
    }

    if (widget.ecommerceRate != null) {
      state.ecommerceRate = widget.ecommerceRate ?? state.ecommerceRate;
    }

    if (widget.errorCost != null) {
      state.errorCost = widget.errorCost ?? state.errorCost;
    }

    if (widget.capex != null) {
      state.capex = widget.capex ?? state.capex;
    }

    if (widget.opex != null) {
      state.opex = widget.opex ?? state.opex;
    }
  }

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
              'Kalkulator Roi',
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
            tittleWidget(icon: Icons.storage, text: '1. Dane hurtowni'),
            SizedBox(height: 8),
            SectionCard(
              child: NumberInput(
                label: "Roczny obrót(PLN)",
                suffix: "zł",
                value: state.yearlyRevenue,
                onChanged: (v) => setState(() => state.yearlyRevenue = v),
              ),
            ),

            SizedBox(height: 8),
            SectionCard(
              child: NumberInput(
                label: "Średnia wartość zamówienia",
                suffix: "zł",
                value: state.avgOrderValue,
                onChanged: (v) => setState(() => state.avgOrderValue = v),
              ),
            ),
            tittleWidget(
              icon: Icons.pie_chart,
              text: '2. Struktura kanałów sprzedaży',
            ),
            SizedBox(height: 8),
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
                    value: state.ecommerceShare,
                    onChanged: (v) => setState(() => state.ecommerceShare = v),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Suma: ${totalShare.toStringAsFixed(0)}%",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isShareValid ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            tittleWidget(
              icon: Icons.attach_money,
              text: '3. Koszt obsługi zamówienia',
            ),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Telefon'),
                      Tooltip(
                        message:
                            "Wynika to z czasu handlowca, przy koszcie godziny pracy w kosztach pracodawcy 60-90zł i 5-20 minutach rozmowy. Patrzymy zazwyczaj na 25-50zł ukrytego kosztu",
                        child: Icon(
                          Icons.info_outlined,
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                    ],
                  ),
                  NumberInput(
                    label: "",
                    value: state.phoneCost,
                    onChanged: (v) => setState(() => state.phoneCost = v),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mail/SMS'),
                      Tooltip(
                        message:
                            "brak rozmowy z klientem, ale dalej trzeba wyklikać w ERPie lub innym systemie",
                        child: Icon(
                          Icons.info_outlined,
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                    ],
                  ),
                  NumberInput(
                    label: "",
                    value: state.mailCost,
                    onChanged: (v) => setState(() => state.mailCost = v),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Osobiste'),
                      Tooltip(
                        message:
                            "Podobny czas jak rozmowa telefonicza + często więcej czasu + toaleta/woda/kawa + większe zamieszanie",
                        child: Icon(
                          Icons.info_outlined,
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                    ],
                  ),
                  NumberInput(
                    label: "",
                    value: state.inPersonCost,
                    onChanged: (v) => setState(() => state.inPersonCost = v),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ecommerce'),
                      Tooltip(
                        message: "Koszt systemu, infrastruktury, magazynu",
                        child: Icon(
                          Icons.info_outlined,
                          color: Color(0xFFCBD5E1),
                        ),
                      ),
                    ],
                  ),
                  NumberInput(
                    label: "",
                    value: state.ecommerceCost,
                    onChanged: (v) => setState(() => state.ecommerceCost = v),
                  ),
                ],
              ),
            ),
            tittleWidget(
              icon: Icons.sync_alt,
              text: '4. Migracja do aplikacji',
            ),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  PercentageInput(
                    label: "z kanału Telefon",
                    value: state.phoneMigration,
                    onChanged: (v) => setState(() => state.phoneMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału mail/sms",
                    value: state.mailMigration,
                    onChanged: (v) => setState(() => state.mailMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału osobiste",
                    value: state.personalMigration,
                    onChanged:
                        (v) => setState(() => state.personalMigration = v),
                  ),
                  PercentageInput(
                    label: "z kanału e-commerce",
                    value: state.ecommerceMigration,
                    onChanged:
                        (v) => setState(() => state.ecommerceMigration = v),
                  ),
                ],
              ),
            ),
            tittleWidget(icon: Icons.show_chart, text: '5. Sprzedaż i Marża'),
            SizedBox(height: 8),
            SectionCard(
              child: Column(
                children: [
                  PercentageInput(
                    label: "Przewidywany wzrost sprzedaży (%)",
                    value: state.salesGrowth,
                    onChanged: (v) => setState(() => state.salesGrowth = v),
                  ),
                  PercentageInput(
                    label: "Marża brutto (%)",
                    value: state.grossMargin,
                    onChanged: (v) => setState(() => state.grossMargin = v),
                  ),
                ],
              ),
            ),
            tittleWidget(
              icon: Icons.warning,
              text: '6. Pomyłki w zamówieniach',
            ),
            SizedBox(height: 8),
            SectionCard(
              child: PercentageInput(
                label: "% pomyłek (kanały tradycyjne)",
                value: state.errorRate,
                onChanged: (v) => setState(() => state.errorRate = v),
              ),
            ),
            SizedBox(height: 8),
            SectionCard(
              child: NumberInput(
                label: "koszt jednej pomyłki",
                suffix: "zł",
                value: state.errorCost,
                onChanged: (v) => setState(() => state.errorCost = v),
              ),
            ),
            const SizedBox(height: 20),
            tittleWidget(
              icon: Icons.wallet,
              text: '7. Koszt projektu aplikacji',
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
                    step: 10000,
                  ),
                  SizedBox(height: 20),
                  SliderInput(
                    label: "OPEX (Utrzymanie rpczne)",
                    value: state.opex,
                    onChanged: (v) => setState(() => state.opex = v),
                    min: 10000,
                    max: 50000,
                    suffix: "zł",
                    step: 5000,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed:
                  isShareValid
                      ? () {
                        final result = RoiCalculator.calculateResult(state);

                        final url =
                            '/results'
                            '?roi=${result.roi}'
                            '&benefit=${result.benefit}'
                            '&marginIncrease=${result.marginIncrease}'
                            '&esavings=${result.errorSavings}'
                            '&msavings=${result.migrationSavings}'
                            '&roitime=${result.RoiTime}'
                            '&selectedIndustry=${widget.selectedIndustry}'
                            '&yearlyRevenue=${state.yearlyRevenue}'
                            '&avgOrderValue=${state.avgOrderValue}'
                            '&phoneShare=${state.phoneShare}'
                            '&mailShare=${state.mailShare}'
                            '&inPersonShare=${state.inPersonShare}'
                            '&ecommerceShare=${state.ecommerceShare}'
                            '&phoneCost=${state.phoneCost}'
                            '&mailCost=${state.mailCost}'
                            '&inPersonCost=${state.inPersonCost}'
                            '&ecommerceCost=${state.ecommerceCost}'
                            '&phoneMigration=${state.phoneMigration}'
                            '&mailMigration=${state.mailMigration}'
                            '&inPersonMigration=${state.personalMigration}'
                            '&ecommerceMigration=${state.ecommerceMigration}'
                            '&salesGrowth=${state.salesGrowth}'
                            '&grossMargin=${state.grossMargin}'
                            '&errorRate=${state.errorRate}'
                            '&ecommerceRate=${state.ecommerceRate}'
                            '&errorCost=${state.errorCost}'
                            '&capex=${state.capex}'
                            '&opex=${state.opex}';
                        context.go(url);
                      }
                      : null,
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
              '© 2026 Wholesale ROI Calculator. Wszystkie prawa\nzastrzeżone.',
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
