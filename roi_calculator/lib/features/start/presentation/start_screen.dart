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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Policz ROI aplikacji\n mobilnej dla\n hurtowni w 2\n minuty",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Narzędzie pozwala oszacować\n potencjalne korzyści z wdrożenia\n aplikacji mobilnej dla twoich klientów.\nDane możnesz w każdej chwili zmienić,a\n wynik jest estymacją.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: industries.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
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
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/calculator?selectedIndustry=${selectedIndustry?.name}',
                    );
                  },
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
                        'Szybka estymacja',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.trending_up, color: Colors.white),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 6. Drobny tekst pod przyciskiem
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, size: 14, color: Colors.blueGrey),
                  SizedBox(width: 4),
                  Text(
                    'Analiza potrwa mniej niż 120 sekund',
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
      ),
    );
  }
}
