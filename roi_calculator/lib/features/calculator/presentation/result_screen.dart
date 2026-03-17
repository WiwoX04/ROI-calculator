import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/assets/services/mail_service.dart';
import 'package:roi_calculator/assets/services/pdf_service.dart';

class ResultScreen extends StatelessWidget {
  final double roi;
  final double benefit;
  final double marginIncrease;
  final double roitime;
  final double esavings;
  final double msavings;
  final selectedIndustry;
  final double yearlyRevenue;
  final double avgOrderValue;

  final double phoneShare;
  final double mailShare;
  final double inPersonShare;
  final double ecommerceShare;

  final double phoneCost;
  final double mailCost;
  final double inPersonCost;
  final double ecommerceCost;
  final double mobileCost;
  final double phoneMigration;
  final double mailMigration;
  final double personalMigration;
  final double ecommerceMigration;

  final double salesGrowth;
  final double grossMargin;

  final double errorRate;
  final double ecommerceRate;
  final double errorCost;

  final double capex;
  final double opex;

  const ResultScreen({
    super.key,
    required this.roi,
    required this.benefit,
    required this.marginIncrease,
    required this.roitime,
    required this.esavings,
    required this.msavings,
    required this.selectedIndustry,

    this.yearlyRevenue = 425000000,
    this.avgOrderValue = 1200,
    this.phoneShare = 50.0,
    this.mailShare = 25.0,
    this.inPersonShare = 10.0,
    this.ecommerceShare = 15.0,
    this.phoneCost = 15.0,
    this.mailCost = 25.0,
    this.inPersonCost = 40.0,
    this.ecommerceCost = 5.0,
    this.mobileCost = 2.0,
    this.phoneMigration = 10.0,
    this.mailMigration = 20.0,
    this.personalMigration = 8.0,
    this.ecommerceMigration = 20.0,
    this.salesGrowth = 3.0,
    this.grossMargin = 20.0,
    this.errorRate = 2.0,
    this.ecommerceRate = 0.5,
    this.errorCost = 50.0,
    this.capex = 140000,
    this.opex = 35000,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Jasne tło aplikacji
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildMetricCard(
              icon: Icons.payments_outlined,
              iconColor: Colors.blue,
              iconBgColor: Colors.blue.withOpacity(0.1),
              title: 'ROCZNA OSZCZĘDNOŚĆ',
              value: "${benefit.round().toString()}zł",
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              icon: Icons.trending_up,
              iconColor: Colors.green,
              iconBgColor: Colors.green.withOpacity(0.1),
              title: 'ROI (ZWROT Z INWESTYCJI)',
              value: '${roi.round()}%',
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              icon: Icons.access_time,
              iconColor: Colors.orange,
              iconBgColor: Colors.orange.withOpacity(0.1),
              title: 'OKRES ZWROTU',
              value: '${roitime.round()} miesięcy',
            ),
            const SizedBox(height: 24),
            _buildVisualisationCard(),
            const SizedBox(height: 24),
            _buildDetailedAnalysisCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 32),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.grid_view_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Kalkulator Roi',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.download_rounded, color: Colors.black54),
          onPressed: () {
            PdfService.downloadPdf(
              roi: roi,
              benefit: benefit,
              marginIncrease: marginIncrease,
              roiTime: roitime,
              errorSavings: esavings,
              migrationSavings: msavings,
              selectedIndustry: selectedIndustry,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Colors.black54),
          onPressed: () {
            if (Platform.isWindows) {
              PdfService.downloadPdf(
                roi: roi,
                benefit: benefit,
                marginIncrease: marginIncrease,
                roiTime: roitime,
                errorSavings: esavings,
                migrationSavings: msavings,
                selectedIndustry: selectedIndustry,
              );
              ;
            } else if (Platform.isAndroid || Platform.isIOS) {
              PdfService.downloadPdfMobile(
                roi: roi,
                benefit: benefit,
                marginIncrease: marginIncrease,
                roiTime: roitime,
                errorSavings: esavings,
                migrationSavings: msavings,
                selectedIndustry: selectedIndustry,
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wyniki Twojej\nestymacji',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Na podstawie wprowadzonych danych\ndotyczących Twojej hurtowni.',
          style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.4),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualisationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Wizualizacja korzyści',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          _buildProgressBar(
            'Oszczędność operacyjna',
            '${msavings.round()} zł',
            msavings / 1000000,
          ),
          const SizedBox(height: 16),
          _buildProgressBar(
            'Wzrost marży',
            '${marginIncrease.round()} zł',
            marginIncrease / 1000000,
          ),
          const SizedBox(height: 16),
          _buildProgressBar(
            'Redukcja błędów',
            '${esavings.round()} zł',
            esavings / 1000000,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, String value, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 8,
                  width: constraints.maxWidth * percentage,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildDetailedAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Szczegółowa analiza\n(Breakdown)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ŹRÓDŁO',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'WARTOŚĆ\nROCZNA',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE2E8F0)),
          _buildAnalysisRow(
            'Oszczędność\noperacyjna',
            '${msavings.round()} zł',
          ),
          _buildAnalysisRow('Wzrost marży', '${marginIncrease.round()} zł'),
          _buildAnalysisRow('Redukcja błędów', '${esavings.round()} zł'),
        ],
      ),
    );
  }

  Widget _buildAnalysisRow(
    String title,
    String value, {
    bool isBlueValue = false,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isBlueValue ? Colors.blue : const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ),
        if (showDivider) const Divider(height: 1, color: Color(0xFFE2E8F0)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final url =
                  '/insights'
                  '?roi=${roi}'
                  '&benefit=${benefit}'
                  '&marginIncrease=${marginIncrease}'
                  '&esavings=${esavings}'
                  '&msavings=${msavings}'
                  '&roitime=${roitime}'
                  '&selectedIndustry=${selectedIndustry}';
              context.go(url);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Tło przycisku
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sprawdź rekomendacje\nwdrożeniowe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
              final url = '/calculator'
                      '?selectedIndustry=${selectedIndustry}'
                      '&yearlyRevenue=${yearlyRevenue}'
                      '&avgOrderValue=${avgOrderValue}'
                      '&phoneShare=${phoneShare}'
                      '&mailShare=${mailShare}'
                      '&inPersonShare=${inPersonShare}'
                      '&ecommerceShare=${ecommerceShare}'
                      '&phoneCost=${phoneCost}'
                      '&mailCost=${mailCost}'
                      '&inPersonCost=${inPersonCost}'
                      '&ecommerceCost=${ecommerceCost}'
                      '&phoneMigration=${phoneMigration}'
                      '&mailMigration=${mailMigration}'
                      '&inPersonMigration=${personalMigration}'
                      '&ecommerceMigration=${ecommerceMigration}'
                      '&salesGrowth=${salesGrowth}'
                      '&grossMargin=${grossMargin}'
                      '&errorRate=${errorRate}'
                      '&ecommerceRate=${ecommerceRate}'
                      '&errorCost=${errorCost}'
                      '&capex=${capex}'
                      '&opex=${opex}'
                  .replaceAll('\n', '')
                  .replaceAll(' ', '');
              context.go(url);
            },
            icon: const Icon(
              Icons.edit_outlined,
              size: 18,
              color: Colors.black87,
            ),
            label: const Text(
              'Edytuj dane',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed:
                () => sendResultsEmail(
                  roiTime: roitime,
                  benefit: benefit,
                  roi: roi,
                  marginIncrease: marginIncrease,
                  migrationSavings: msavings,
                  errorSavings: esavings,
                  selectedIndustry: selectedIndustry,
                ),
            icon: const Icon(
              Icons.mail_outline,
              size: 18,
              color: Colors.black87,
            ),
            label: const Text(
              'Wyślij e-mailem',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey[300]!),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Center(
        child: Text(
          '© 2026 ROI Calculator. Wszystkie prawa\nzastrzeżone.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.grey[500], height: 1.5),
        ),
      ),
    );
  }
}
