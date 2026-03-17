import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    // Przekazujemy dane z FinishScreen do ResultScreen
    return FinScreen(
      roi: roi,
      benefit: benefit,
      marginIncrease: marginIncrease,
      roitime: roitime,
      esavings: esavings,
      msavings: msavings,
      selectedIndustry: selectedIndustry,
    );
  }
}

class FinScreen extends StatelessWidget {
  // DODANE: Pola, które musi przyjąć ResultScreen
  final double roi;
  final double benefit;
  final double marginIncrease;
  final double roitime;
  final double esavings;
  final double msavings;
  final dynamic selectedIndustry;

  // DODANE: Konstruktor przyjmujący dane
  const FinScreen({
    super.key,
    required this.roi,
    required this.benefit,
    required this.marginIncrease,
    required this.roitime,
    required this.esavings,
    required this.msavings,
    required this.selectedIndustry,
  });

  // Definicja głównych kolorów
  final Color primaryBlue = const Color(0xFF007BFF);
  final Color lightBlueBg = const Color(0xFFE6F2FF);
  final Color textDark = const Color(0xFF0F172A);
  final Color textGray = const Color(0xFF64748B);
  final Color bgGray = const Color(0xFFF8FAFC);
  final Color borderGray = const Color(0xFFE2E8F0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Tło poza główną kartą
      body: SafeArea(
        child: SingleChildScrollView(
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
                      // Nagłówek: Ikona + Wholesale ROI
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
                            'Kalkulator Roi',
                            style: TextStyle(
                              color: textDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // Duża ikona sukcesu
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
                            child: Icon(
                              Icons.check,
                              color: primaryBlue,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Tytuł
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
                      const SizedBox(height: 16),

                      // Opis
                      Text(
                        'Twoja kalkulacja jest bezpieczna.\nMożesz do niej wrócić w dowolnym\nmomencie lub pobrać ją jako\nprofesjonalny raport PDF.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: textGray,
                          height: 1.5,
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
                                  '/results'
                                  '?roi=${roi}'
                                  '&benefit=${benefit}'
                                  '&marginIncrease=${marginIncrease}'
                                  '&esavings=${esavings}'
                                  '&msavings=${msavings}'
                                  '&roitime=${roitime}'
                                  '&selectedIndustry=${selectedIndustry}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: textDark,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 56,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          '/results'
                                          '?roi=${roi}'
                                          '&benefit=${benefit}'
                                          '&marginIncrease=${marginIncrease}'
                                          '&esavings=${esavings}'
                                          '&msavings=${msavings}'
                                          '&roitime=${roitime}'
                                          '&selectedIndustry=${selectedIndustry}',
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Link skopiowany do schowka!',
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.copy,
                                  color: primaryBlue,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Przyciski akcji
                      _buildButton(
                        text: 'Pobierz raport PDF',
                        icon: Icons.picture_as_pdf_outlined,
                        bgColor: primaryBlue,
                        textColor: Colors.white,
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
                      const SizedBox(height: 12),
                      _buildButton(
                        text: 'Powtórz kalkulację',
                        icon: Icons.refresh,
                        bgColor: bgGray,
                        textColor: textDark,
                        onPressed: () {
                          context.go('/');
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildButton(
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

                      // Karty z cechami (Features)
                      _buildFeatureCard(
                        icon: Icons.verified_outlined,
                        title: 'Dokładne dane',
                        subtitle: 'Wyliczenia oparte o marże hurtowe',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureCard(
                        icon: Icons.lock_outline,
                        title: 'Prywatność',
                        subtitle: 'Twoje dane są szyfrowane',
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureCard(
                        icon: Icons.cloud_done_outlined,
                        title: 'Autozapis',
                        subtitle: 'Dostępne na każdym urządzeniu',
                      ),
                    ],
                  ),
                ),

                // Stopka
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
        ),
      ),
    );
  }

  // Pomocnicza metoda do budowania przycisków
  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required onPressed,
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
          shadowColor: Colors.transparent,
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

  // Pomocnicza metoda do budowania kart z cechami na dole
  Widget _buildFeatureCard({
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
