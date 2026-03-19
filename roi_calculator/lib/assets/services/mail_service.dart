import 'package:url_launcher/url_launcher.dart';

Future<void> sendResultsEmail({
  required double roi,
  required double benefit,
  required double marginIncrease,
  required double roiTime,
  required double errorSavings,
  required double migrationSavings,
  required String selectedIndustry, // Twój model RoiResult
}) async {
  // 1. Tworzymy czytelną treść maila
  final String body = '''
Raport ROI Calculator
Branża: $selectedIndustry

WYNIKI:
----------------------------------
ROI: ${roi.toStringAsFixed(2)}%
Całkowita korzyść roczna: ${benefit.toStringAsFixed(2)} zł
Wzrost marży: ${marginIncrease.toStringAsFixed(2)} zł
Oszczędności na błędach: ${errorSavings.toStringAsFixed(2)} zł
Oszczędności na migracji: ${migrationSavings.toStringAsFixed(2)} zł
Czas zwrotu (ROI Time): ${roiTime.toStringAsFixed(1)} mies.

Wygenerowano automatycznie przez ROI Calculator.
''';

  // 2. Konstruujemy URI
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: '', // Możesz tu wpisać domyślnego maila, np. 'biuro@firma.pl'
    query: _encodeQueryParameters({
      'subject':
          'Raport ROI - $selectedIndustry - ${DateTime.now().toString().substring(0, 10)}',
      'body': body,
    }),
  );

  // 3. Odpalamy aplikację mailową
  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    // Obsługa błędu, np. brak klienta poczty
    print('Nie można otworzyć aplikacji mailowej');
  }
}

// Pomocnicza funkcja do poprawnego kodowania parametrów URL
String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map(
        (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
      .join('&');
}
