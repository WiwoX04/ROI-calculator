import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InsightsScreen extends StatelessWidget {
  final double roi;
  final double benefit;
  final double marginIncrease;
  final double roitime;
  final double esavings;
  final double msavings;
  final dynamic selectedIndustry;

  const InsightsScreen({
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
    return Scaffold(
      backgroundColor: const Color(0xF8FAFC),
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
              'Kalkulator Roi',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Obliczamy liczbę kolumn na podstawie szerokości ekranu
              int crossAxisCount = constraints.maxWidth > 900 ? 3 : 1;

              // Obliczamy szerokość pojedynczej karty (odejmujemy odstępy)
              double spacing = 20.0;
              double itemWidth =
                  (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                  crossAxisCount;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Jak dowieźć taki\nwynik w praktyce?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                      color: Color(0xFF1A1F2C),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Wdrożenie aplikacji to nie tylko\ntechnologia, to przede wszystkim\nwygoda Twoich klientów i\nefektywność procesów.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Kontener z kartami ułożonymi responsywnie
                  Wrap(
                    spacing: spacing, // Odstęp poziomy
                    runSpacing: spacing, // Odstęp pionowy
                    alignment: WrapAlignment.center,
                    children: [
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.wifi_off,
                        title: 'Obsługa offline',
                        description:
                            'Na budowach często nie ma internetu. Aplikacja musi działać płynnie bez zasięgu.',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.smartphone,
                        title: 'Prosty UX mobilny',
                        description:
                            'Strony e-commerce są trudne w użyciu na telefonie. Dedykowana aplikacja to 3x szybsze zamówienie.',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.notifications_outlined,
                        title: 'Powiadomienia Push',
                        description:
                            'Tańsze niż SMS i bardziej skuteczne. Bezpośredni kanał dotarcia z promocjami.',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.touch_app,
                        title: 'Duże przyciski',
                        description:
                            'Użytkownicy często mają rękawice lub pracują w trudnych warunkach. UI musi być \'pancerny\'',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.wb_sunny_outlined,
                        title: 'Jasny motyw i kontrast',
                        description:
                            'Lepsza widoczność w słońcu na budowie. Opcjonalny tryb ciemny do pracy w ciemnych piwnicach.',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.group,
                        title: 'Współpraca handlowców',
                        description:
                            'System prowizyjny musi wspierać zamówienia online, by handlowcy byli ambasadorami aplikacji.',
                      ),
                      _buildFeatureCard(
                        width: itemWidth,
                        icon: Icons.build,
                        title: 'Narzędzia branżowe',
                        description:
                            'Kalkulatory i przeliczniki wbudowane w aplikacje to ekstra wartość, która przyciąga klienta codziennie.',
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Przycisk "Dalej" - ograniczamy jego szerokość na Webie, żeby nie był gigantyczny
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go(
                            '/finish?roi=$roi'
                            '&benefit=$benefit'
                            '&marginIncrease=$marginIncrease'
                            '&esavings=$esavings'
                            '&msavings=$msavings'
                            '&roitime=$roitime'
                            '&selectedIndustry=$selectedIndustry',
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007BFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Dalej',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_right_alt, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '© 2026 Wholesale ROI Calculator. Wszystkie prawa\nzastrzeżone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required double width,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: width,
      // Minimalna wysokość, aby karty w jednym rzędzie były równe nawet przy różnej długości tekstu
      constraints: const BoxConstraints(minHeight: 220),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF007BFF), size: 24),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1F2C),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.blueGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
