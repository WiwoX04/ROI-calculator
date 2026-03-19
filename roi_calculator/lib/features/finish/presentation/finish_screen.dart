import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/assets/services/pdf_service.dart';

class FinishScreen extends StatelessWidget {
  final double roi;
  final double benefit;
  final double marginIncrease;
  final double roitime;
  final double esavings;
  final double msavings;
  final dynamic selectedIndustry;

  const FinishScreen({
    super.key,
    required this.roi,
    required this.benefit,
    required this.marginIncrease,
    required this.roitime,
    required this.esavings,
    required this.msavings,
    required this.selectedIndustry,
  });

  // Wspólne kolory
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlueBg = const Color(0xFFE6F2FF);
  final Color textDark = const Color(0xFF0F172A);
  final Color textGray = const Color(0xFF64748B);
  final Color bgGray = const Color(0xFFFFFFFF);
  final Color borderGray = const Color(0xFFF8FAFC);

  String _generateResultLink() {
    return '/results'
        '?roi=$roi'
        '&benefit=$benefit'
        '&marginIncrease=$marginIncrease'
        '&esavings=$esavings'
        '&msavings=$msavings'
        '&roitime=$roitime'
        '&selectedIndustry=$selectedIndustry'; // Tutaj wstawisz właściwą logikę generowania linku
  }

  // Wspólna logika pobierania PDF, żeby nie duplikować kodu w obu widokach
  void _handlePdfDownload() {
    if (kIsWeb) {
      PdfService.downloadPdf(
        roi: roi,
        benefit: benefit,
        marginIncrease: marginIncrease,
        roiTime: roitime,
        errorSavings: esavings,
        migrationSavings: msavings,
        selectedIndustry: selectedIndustry,
      );
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
    } else {
      PdfService.downloadPdf(
        roi: roi,
        benefit: benefit,
        marginIncrease: marginIncrease,
        roiTime: roitime,
        errorSavings: esavings,
        migrationSavings: msavings,
        selectedIndustry: selectedIndustry,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String resultLink = _generateResultLink();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Jeśli ekran jest szerszy niż 800px, pokazujemy wersję Web
            if (constraints.maxWidth > 800) {
              return _buildWebLayout(context, resultLink);
            }
            // W przeciwnym razie pokazujemy wersję Mobile
            else {
              return _buildMobileLayout(context, resultLink);
            }
          },
        ),
      ),
    );
  }

  // =========================================================================
  // 1. WERSJA WEB (Wyśrodkowana, bez "Udostępnij", poziome karty)
  // =========================================================================
  Widget _buildWebLayout(BuildContext context, String resultLink) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.calculate,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Wholesale ROI',
                    style: TextStyle(
                      color: textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),

              // Ikona sukcesu
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: lightBlueBg,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryBlue, width: 3),
                    ),
                    child: Icon(Icons.check, color: primaryBlue, size: 36),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Tytuł i opis
              Text(
                'Wynik został zapisany!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: textDark,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),

              // Link
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Twój unikalny link do wyniku',
                    style: TextStyle(
                      fontSize: 12,
                      color: textGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: bgGray,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderGray),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            resultLink,
                            style: TextStyle(color: textDark, fontSize: 14),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: resultLink));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Link skopiowany!')),
                            );
                          },
                          icon: Icon(
                            Icons.copy_rounded,
                            color: primaryBlue,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Przyciski (Tylko 2, wyśrodkowane i zwężone)
              _buildWebMainButton(
                text: 'Pobierz raport PDF',
                icon: Icons.picture_as_pdf,
                isPrimary: true,
                onPressed: _handlePdfDownload,
              ),
              const SizedBox(height: 12),
              _buildWebMainButton(
                text: 'Powtórz kalkulację',
                icon: Icons.refresh_rounded,
                isPrimary: false,
                onPressed: () => context.go('/'),
              ),
              const SizedBox(height: 60),

              // Karty korzyści (W poziomie)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWebSmallFeature(
                    Icons.check_circle_outline,
                    'Dokładne dane',
                    'Wyliczenia oparte o marże',
                  ),
                  const SizedBox(width: 12),
                  _buildWebSmallFeature(
                    Icons.cloud_done_outlined,
                    'Autozapis',
                    'Dostępne na urządzeniu',
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Stopka
              Text(
                '© 2026 Wholesale ROI Calculator. Wszystkie prawa zastrzeżone.',
                style: TextStyle(
                  fontSize: 12,
                  color: textGray.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // 2. WERSJA MOBILE (Pionowa, przycisk "Udostępnij", pełna szerokość)
  // =========================================================================
  Widget _buildMobileLayout(BuildContext context, String resultLink) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Główna biała karta
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Nagłówek
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.calculate_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Kalkulator ROI',
                        style: TextStyle(
                          color: textDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Ikona sukcesu
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: lightBlueBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryBlue, width: 3),
                        ),
                        child: Icon(Icons.check, color: primaryBlue, size: 32),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text(
                    'Wynik został\nzapisany!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sekcja z linkiem
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Twój unikalny link do wyniku',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: textGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: bgGray,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderGray),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              resultLink,
                              style: TextStyle(fontSize: 13, color: textDark),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: resultLink));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Link skopiowany do schowka!'),
                              ),
                            );
                          },
                          icon: Icon(Icons.copy, color: primaryBlue, size: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Przyciski akcji (Z przyciskiem udostępnij)
                  _buildMobileButton(
                    text: 'Pobierz raport PDF',
                    icon: Icons.picture_as_pdf_outlined,
                    bgColor: primaryBlue,
                    textColor: Colors.white,
                    onPressed: _handlePdfDownload,
                  ),
                  const SizedBox(height: 12),
                  _buildMobileButton(
                    text: 'Powtórz kalkulację',
                    icon: Icons.refresh,
                    bgColor: bgGray,
                    textColor: textDark,
                    onPressed: () => context.go('/'),
                  ),
                  const SizedBox(height: 12),
                  _buildMobileButton(
                    text: 'Udostępnij wynik',
                    icon: Icons.share_outlined,
                    bgColor: Colors.white,
                    textColor: primaryBlue,
                    borderColor: primaryBlue,
                    onPressed: () {
                      PdfService.sharePdf(
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
                  const SizedBox(height: 32),

                  // Karty korzyści (W pionie)
                  _buildMobileFeatureCard(
                    icon: Icons.verified_outlined,
                    title: 'Dokładne dane',
                    subtitle: 'Wyliczenia oparte o marże hurtowe',
                  ),

                  const SizedBox(height: 12),
                  _buildMobileFeatureCard(
                    icon: Icons.cloud_done_outlined,
                    title: 'Autozapis',
                    subtitle: 'Dostępne na każdym urządzeniu',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '© 2024 Wholesale ROI Calculator. Wszystkie prawa\nzastrzeżone.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: textGray),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // WIDGETY POMOCNICZE (Wydzielone dla porządku)
  // =========================================================================

  // Web: Przycisk główny (zwężony)
  Widget _buildWebMainButton({
    required String text,
    required IconData icon,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 400,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20),
        label: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? primaryBlue : bgGray,
          foregroundColor: isPrimary ? Colors.white : textDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // Web: Mała karta w rzędzie
  Widget _buildWebSmallFeature(IconData icon, String title, String sub) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: bgGray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryBlue, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sub,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: textGray, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }

  // Mobile: Przycisk (pełna szerokość)
  Widget _buildMobileButton({
    required String text,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onPressed,
    Color? borderColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: textColor, size: 20),
        label: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side:
                borderColor != null
                    ? BorderSide(color: borderColor, width: 1.5)
                    : BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Mobile: Karta w kolumnie
  Widget _buildMobileFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryBlue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: TextStyle(fontSize: 11, color: textGray)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
