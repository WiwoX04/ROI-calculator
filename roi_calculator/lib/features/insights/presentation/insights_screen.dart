import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF8F9FB,
      ), // Jasne tło, takie jak wcześniej
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Dodajemy przycisk powrotu (jeśli to kolejny ekran)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              'Wholesale ROI',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Główny tytuł
              const Text(
                'Jak dowieźć taki\nwynik w praktyce?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  color: Color(0xFF1A1F2C), // Ciemny granat/czerń
                ),
              ),
              const SizedBox(height: 16),

              // 2. Podtytuł
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

              _buildFeatureCard(
                icon: Icons.wifi_off,
                title: 'Obsługa offline',
                description:
                    'Na budowach często nie ma internetu. Aplikacja musi działać płynnie bez zasięgu.',
              ),
              const SizedBox(height: 20),

              _buildFeatureCard(
                icon: Icons.smartphone,
                title: 'Prosty UX mobilny',
                description:
                    'Strony e-commerce są trudne w użyciu na telefonie. Dedykowana aplikacja to 3x szybsze zamówienie.',
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                icon: Icons.notifications_outlined,
                title: 'Powiadomienia Push',
                description:
                    'Tańsze niż SMS i bardziej\nskuteczne. Bezpośredni kanał\ndotarcia z promocjami.',
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Duże przyciski',
                description:
                    'Użytkownicy często mają rękawice lub pracują w trudnych warunkach. UI musi być \'pancerny\'',
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Jasny motyw i kontrast',
                description:
                    'Lepsza widoczność w słońcu na budowie. Opcjonalny tryb ciemny do pracy w ciemnych piwnicach.',
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Współpraca handlowców',
                description:
                    'System prowizyjny musi wspierać zamówienia online, by handlowcy byli ambasadorami aplikacji.',
              ),
              const SizedBox(height: 20),
              _buildFeatureCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Narzędzia branżowe',
                description:
                    'Kalkulatory i przeliczniki wbudowane w aplikacje to ekstra wartość, która przyciąga klienta codziennie.',
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFF007BFF,
                    ), // Jaskrawy niebieski
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
      ),
    );
  }

  // Metoda budująca pojedynczą kartę informacyjną
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0), // Duży wewnętrzny margines (oddech)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200, // Delikatna ramka
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikona w jasnoniebieskim kwadracie
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2FF), // Bardzo jasny niebieski
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF007BFF), // Jaskrawy niebieski
              size: 24,
            ),
          ),
          const SizedBox(height: 20),

          // Tytuł karty
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1F2C),
            ),
          ),
          const SizedBox(height: 12),

          // Opis karty
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
