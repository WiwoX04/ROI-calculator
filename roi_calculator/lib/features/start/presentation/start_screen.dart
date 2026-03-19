import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/features/calculator/data/industries.dart';
import 'package:roi_calculator/features/start/choosing_card.dart';
import 'package:roi_calculator/models/industry_type_model.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  IndustryType? selectedIndustry;

  @override
  Widget build(BuildContext context) {
    // Odczytujemy szerokość ekranu dla responsywności siatki
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 3;
    if (screenWidth < 600) {
      crossAxisCount = 1;
    } else if (screenWidth < 900) {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: const Color(
        0xFFF8FAFC,
      ), // Bardzo jasne szare tło z designu
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        surfaceTintColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF007BFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.grid_view_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Kalkulator ROI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 850,
            ), // Ograniczenie szerokości na PC/Web
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 48.0,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Wyrównanie do lewej
                children: [
                  // 1. Tytuł
                  const Text(
                    "Policz ROI aplikacji mobilnej dla hurtowni w 2 minuty",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 42,
                      height: 1.1,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 2. Sub-tytuł
                  const Text(
                    "Narzędzie pozwala oszacować potencjalne korzyści z wdrożenia aplikacji mobilnej dla Twoich klientów. Dane możesz w każdej chwili zmienić, a wynik jest estymacją.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // 3. Nagłówek siatki
                  Row(
                    children: [
                      const Icon(
                        Icons.storefront_outlined,
                        color: Color(0xFF007BFF),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Wybór typu hurtowni",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 4. Siatka (Grid) z kartami
                  GridView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), // Scrollowanie obsługuje SingleChildScrollView
                    shrinkWrap: true,
                    itemCount: industries.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio:
                          1.4, // Zmienione proporcje karty (szersza niż wyższa)
                    ),
                    itemBuilder: (context, index) {
                      final industry = industries[index];
                      return IndustryCard(
                        industry: industry,
                        selected: selectedIndustry == industry,
                        onTap: () {
                          setState(() {
                            selectedIndustry = industry;
                          });
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 48),

                  // 5. Przycisk (Wyśrodkowany)
                  Center(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                            selectedIndustry == null
                                ? null // Przycisk wyłączony, dopóki nie wybierzemy branży
                                : () {
                                  context.go(
                                    '/calculator?selectedIndustry=${selectedIndustry?.name}',
                                  );
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007BFF),
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(horizontal: 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              100,
                            ), // Kształt pigułki z designu
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize
                                  .min, // Przycisk dopasowuje się do tekstu
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Szybka estymacja',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_outward,
                              color: Colors.white,
                              size: 20,
                            ), // Strzałka "w prawo do góry"
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 6. Drobny tekst pod przyciskiem
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.bolt, size: 16, color: Color(0xFF94A3B8)),
                        SizedBox(width: 4),
                        Text(
                          'Analiza potrwa mniej niż 120 sekund',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),

                  // 7. Stopka
                  const Center(
                    child: Text(
                      '© 2026 ROI Calculator. Wszelkie prawa zastrzeżone.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
