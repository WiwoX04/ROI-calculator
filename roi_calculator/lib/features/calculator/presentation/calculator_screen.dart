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
    if (widget.yearlyRevenue != null)
      state.yearlyRevenue = widget.yearlyRevenue!;
    if (widget.avgOrderValue != null)
      state.avgOrderValue = widget.avgOrderValue!;
    if (widget.phoneShare != null) state.phoneShare = widget.phoneShare!;
    if (widget.mailShare != null) state.mailShare = widget.mailShare!;
    if (widget.inPersonShare != null)
      state.inPersonShare = widget.inPersonShare!;
    if (widget.ecommerceShare != null)
      state.ecommerceShare = widget.ecommerceShare!;
    if (widget.phoneCost != null) state.phoneCost = widget.phoneCost!;
    if (widget.mailCost != null) state.mailCost = widget.mailCost!;
    if (widget.inPersonCost != null) state.inPersonCost = widget.inPersonCost!;
    if (widget.ecommerceCost != null)
      state.ecommerceCost = widget.ecommerceCost!;
    if (widget.mobileCost != null) state.mobileCost = widget.mobileCost!;
    if (widget.phoneMigration != null)
      state.phoneMigration = widget.phoneMigration!;
    if (widget.mailMigration != null)
      state.mailMigration = widget.mailMigration!;
    if (widget.personalMigration != null)
      state.personalMigration = widget.personalMigration!;
    if (widget.ecommerceMigration != null)
      state.ecommerceMigration = widget.ecommerceMigration!;
    if (widget.salesGrowth != null) state.salesGrowth = widget.salesGrowth!;
    if (widget.grossMargin != null) state.grossMargin = widget.grossMargin!;
    if (widget.errorRate != null) state.errorRate = widget.errorRate!;
    if (widget.ecommerceRate != null)
      state.ecommerceRate = widget.ecommerceRate!;
    if (widget.errorCost != null) state.errorCost = widget.errorCost!;
    if (widget.capex != null) state.capex = widget.capex!;
    if (widget.opex != null) state.opex = widget.opex!;
  }

  // Wspólna metoda do przeliczania i nawigacji, żeby nie duplikować kodu
  void _calculateAndNavigate() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Color(0xFFFFFFFF),
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
              'Kalkulator ROI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return _buildWebLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  // =========================================================================
  // 1. WERSJA WEB (Wyśrodkowana, układ kafelkowy wg zdjęcia)
  // =========================================================================
  Widget _buildWebLayout() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 900),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Dane hurtowni
              tittleWidget(icon: Icons.storage, text: '1. Dane hurtowni'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SectionCard(
                      child: NumberInput(
                        label: "Roczny obrót(PLN)",
                        suffix: "zł",
                        value: state.yearlyRevenue,
                        onChanged:
                            (v) => setState(() => state.yearlyRevenue = v),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SectionCard(
                      child: NumberInput(
                        label: "Średnia wartość zamówienia",
                        suffix: "zł",
                        value: state.avgOrderValue,
                        onChanged:
                            (v) => setState(() => state.avgOrderValue = v),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 2. Struktura kanałów sprzedaży (Wszystko w jednej karcie w jednym rzędzie)
              tittleWidget(
                icon: Icons.pie_chart,
                text: '2. Struktura kanałów sprzedaży',
              ),
              const SizedBox(height: 8),
              SectionCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: PercentageInput(
                            label: "TELEFON",
                            value: state.phoneShare,
                            onChanged:
                                (v) => setState(() => state.phoneShare = v),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PercentageInput(
                            label: "MAIL / SMS",
                            value: state.mailShare,
                            onChanged:
                                (v) => setState(() => state.mailShare = v),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PercentageInput(
                            label: "OSOBISTE",
                            value: state.inPersonShare,
                            onChanged:
                                (v) => setState(() => state.inPersonShare = v),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: PercentageInput(
                            label: "E-COMMERCE",
                            value: state.ecommerceShare,
                            onChanged:
                                (v) => setState(() => state.ecommerceShare = v),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Suma kanałów:",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            "${totalShare.toStringAsFixed(0)}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isShareValid ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 3. Koszt obsługi zamówienia (4 osobne karty w rzędzie)
              tittleWidget(
                icon: Icons.attach_money,
                text: '3. Koszt obsługi zamówienia',
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SectionCard(
                      child: Column(
                        children: [
                          _buildLabelWithTooltip(
                            'Telefon',
                            "Koszt czasu handlowca...",
                          ),
                          NumberInput(
                            label: "",
                            value: state.phoneCost,
                            onChanged:
                                (v) => setState(() => state.phoneCost = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SectionCard(
                      child: Column(
                        children: [
                          _buildLabelWithTooltip(
                            'Mail/SMS',
                            "Brak rozmowy, ale trzeba wyklikać...",
                          ),
                          NumberInput(
                            label: "",
                            value: state.mailCost,
                            onChanged:
                                (v) => setState(() => state.mailCost = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SectionCard(
                      child: Column(
                        children: [
                          _buildLabelWithTooltip(
                            'Osobiste',
                            "Więcej czasu, zamieszanie...",
                          ),
                          NumberInput(
                            label: "",
                            value: state.inPersonCost,
                            onChanged:
                                (v) => setState(() => state.inPersonCost = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SectionCard(
                      child: Column(
                        children: [
                          _buildLabelWithTooltip(
                            'Ecommerce',
                            "Infrastruktura...",
                          ),
                          NumberInput(
                            label: "",
                            value: state.ecommerceCost,
                            onChanged:
                                (v) => setState(() => state.ecommerceCost = v),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sekcja 4 i 5 obok siebie
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 4. Migracja
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tittleWidget(
                          icon: Icons.sync_alt,
                          text: '4. Migracja do aplikacji',
                        ),
                        const SizedBox(height: 8),
                        SectionCard(
                          child: Column(
                            children: [
                              PercentageInput(
                                label: "Z kanału Telefon",
                                value: state.phoneMigration,
                                onChanged:
                                    (v) => setState(
                                      () => state.phoneMigration = v,
                                    ),
                              ),
                              PercentageInput(
                                label: "Z kanału Mail/SMS",
                                value: state.mailMigration,
                                onChanged:
                                    (v) =>
                                        setState(() => state.mailMigration = v),
                              ),
                              PercentageInput(
                                label: "Z kanału Osobiste",
                                value: state.personalMigration,
                                onChanged:
                                    (v) => setState(
                                      () => state.personalMigration = v,
                                    ),
                              ),
                              PercentageInput(
                                label: "Z kanału E-commerce",
                                value: state.ecommerceMigration,
                                onChanged:
                                    (v) => setState(
                                      () => state.ecommerceMigration = v,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  // 5. Sprzedaż i Marża
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tittleWidget(
                          icon: Icons.show_chart,
                          text: '5. Sprzedaż i Marża',
                        ),
                        const SizedBox(height: 8),
                        SectionCard(
                          child: Column(
                            children: [
                              PercentageInput(
                                label: "Wzrost sprzedaży",
                                value: state.salesGrowth,
                                onChanged:
                                    (v) =>
                                        setState(() => state.salesGrowth = v),
                              ),
                              PercentageInput(
                                label: "Marża brutto",
                                value: state.grossMargin,
                                onChanged:
                                    (v) =>
                                        setState(() => state.grossMargin = v),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 6. Pomyłki w zamówieniach (2 osobne karty w rzędzie)
              tittleWidget(
                icon: Icons.warning,
                text: '6. Pomyłki w zamówieniach',
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: SectionCard(
                      child: PercentageInput(
                        label: "% pomyłek (kanały tradycyjne)",
                        value: state.errorRate,
                        onChanged: (v) => setState(() => state.errorRate = v),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SectionCard(
                      child: NumberInput(
                        label: "Koszt jednej pomyłki",
                        suffix: "zł",
                        value: state.errorCost,
                        onChanged: (v) => setState(() => state.errorCost = v),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 7. Koszt projektu (Cała szerokość)
              tittleWidget(
                icon: Icons.wallet,
                text: '7. Koszt projektu aplikacji',
              ),
              const SizedBox(height: 8),
              SectionCard(
                child: Column(
                  children: [
                    SliderInput(
                      label: "CAPEX (Wdrożenie jednorazowe)",
                      value: state.capex,
                      onChanged: (v) => setState(() => state.capex = v),
                      min: 80000,
                      max: 200000,
                      suffix: "zł",
                      step: 10000,
                    ),
                    const SizedBox(height: 20),
                    SliderInput(
                      label: "OPEX (Utrzymanie miesięczne)",
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
              const SizedBox(height: 40),

              // Przycisk i stopka
              _buildSubmitButton(),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Wszystkie dane zostaną zapisane automatycznie',
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  '© 2026 ROI Calculator. Wszelkie prawa zastrzeżone.',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 2. WERSJA MOBILE (Pionowa, dokładnie Twój poprzedni kod)
  // =========================================================================
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tittleWidget(icon: Icons.storage, text: '1. Dane hurtowni'),
          const SizedBox(height: 8),
          SectionCard(
            child: NumberInput(
              label: "Roczny obrót(PLN)",
              suffix: "zł",
              value: state.yearlyRevenue,
              onChanged: (v) => setState(() => state.yearlyRevenue = v),
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: NumberInput(
              label: "Średnia wartość zamówienia",
              suffix: "zł",
              value: state.avgOrderValue,
              onChanged: (v) => setState(() => state.avgOrderValue = v),
            ),
          ),

          const SizedBox(height: 20),
          tittleWidget(
            icon: Icons.pie_chart,
            text: '2. Struktura kanałów sprzedaży',
          ),
          const SizedBox(height: 8),
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

          const SizedBox(height: 20),
          tittleWidget(
            icon: Icons.attach_money,
            text: '3. Koszt obsługi zamówienia',
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: Column(
              children: [
                _buildLabelWithTooltip(
                  'Telefon',
                  "Wynika to z czasu handlowca...",
                ),
                NumberInput(
                  label: "",
                  value: state.phoneCost,
                  onChanged: (v) => setState(() => state.phoneCost = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: Column(
              children: [
                _buildLabelWithTooltip(
                  'Mail/SMS',
                  "brak rozmowy z klientem...",
                ),
                NumberInput(
                  label: "",
                  value: state.mailCost,
                  onChanged: (v) => setState(() => state.mailCost = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: Column(
              children: [
                _buildLabelWithTooltip(
                  'Osobiste',
                  "Podobny czas jak rozmowa...",
                ),
                NumberInput(
                  label: "",
                  value: state.inPersonCost,
                  onChanged: (v) => setState(() => state.inPersonCost = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: Column(
              children: [
                _buildLabelWithTooltip('Ecommerce', "Koszt systemu..."),
                NumberInput(
                  label: "",
                  value: state.ecommerceCost,
                  onChanged: (v) => setState(() => state.ecommerceCost = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          tittleWidget(icon: Icons.sync_alt, text: '4. Migracja do aplikacji'),
          const SizedBox(height: 8),
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
                  onChanged: (v) => setState(() => state.personalMigration = v),
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

          const SizedBox(height: 20),
          tittleWidget(icon: Icons.show_chart, text: '5. Sprzedaż i Marża'),
          const SizedBox(height: 8),
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

          const SizedBox(height: 20),
          tittleWidget(icon: Icons.warning, text: '6. Pomyłki w zamówieniach'),
          const SizedBox(height: 8),
          SectionCard(
            child: PercentageInput(
              label: "% pomyłek (kanały tradycyjne)",
              value: state.errorRate,
              onChanged: (v) => setState(() => state.errorRate = v),
            ),
          ),
          const SizedBox(height: 8),
          SectionCard(
            child: NumberInput(
              label: "koszt jednej pomyłki",
              suffix: "zł",
              value: state.errorCost,
              onChanged: (v) => setState(() => state.errorCost = v),
            ),
          ),

          const SizedBox(height: 20),
          tittleWidget(icon: Icons.wallet, text: '7. Koszt projektu aplikacji'),
          const SizedBox(height: 8),
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
                const SizedBox(height: 20),
                SliderInput(
                  label: "OPEX (Utrzymanie roczne)",
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
          const SizedBox(height: 20),

          _buildSubmitButton(),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Wszystkie dane zostaną zapisane automatycznie',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              '© 2026 ROI Calculator. Wszystkie prawa\nzastrzeżone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =========================================================================
  // WIDGETY POMOCNICZE
  // =========================================================================

  Widget _buildLabelWithTooltip(String title, String tooltipMessage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Tooltip(
          message: tooltipMessage,
          child: const Icon(Icons.info_outlined, color: Color(0xFFCBD5E1)),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isShareValid ? _calculateAndNavigate : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF007BFF),
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
    );
  }
}
