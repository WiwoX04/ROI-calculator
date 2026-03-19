import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;
import 'package:printing/printing.dart';

class PdfService {
  // 1. WSPÓLNA FUNKCJA GENERUJĄCA WYGLĄD PDF
  static Future<Uint8List> _generatePdfContent({
    required double roi,
    required double benefit,
    required double marginIncrease,
    required double roiTime,
    required double errorSavings,
    required double migrationSavings,
    required dynamic selectedIndustry,
  }) async {
    final font = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();
    final pdf = pw.Document(
      theme: pw.ThemeData.withFont(base: font, bold: fontBold),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Raport Wholesale ROI',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Branża: $selectedIndustry'),
              pw.SizedBox(height: 10),
              pw.Text('Roczna oszczędność: ${benefit.round()} PLN'),
              pw.Text('Zwrot z inwestycji (ROI): ${roi.round()}%'),
              pw.Text('Okres zwrotu: ${roiTime.round()} miesięcy'),
              pw.SizedBox(height: 10),
              pw.Text(
                'Szczegóły:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text('- Wzrost marży: ${marginIncrease.round()} PLN'),
              pw.Text('- Redukcja błędów: ${errorSavings.round()} PLN'),
              pw.Text(
                '- Oszczędność operacyjna: ${migrationSavings.round()} PLN',
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> downloadPdfMobile({
    required double roi,
    required double benefit,
    required double marginIncrease,
    required double roiTime,
    required double errorSavings,
    required double migrationSavings,
    required dynamic selectedIndustry,
  }) async {
    // 1. Generujemy bajty PDF (Twoja istniejąca funkcja)
    final bytes = await _generatePdfContent(
      roi: roi,
      benefit: benefit,
      marginIncrease: marginIncrease,
      roiTime: roiTime,
      errorSavings: errorSavings,
      migrationSavings: migrationSavings,
      selectedIndustry: selectedIndustry,
    );

    // 2. Zamiast ręcznego zapisywania, używamy Printing
    // Na Web: otworzy okno drukowania/zapisu przeglądarki
    // Na Mobile: otworzy systemowy podgląd z opcją zapisu/udostępnienia
    await Printing.layoutPdf(
      onLayout: (format) async => bytes,
      name: 'Raport_ROI_${selectedIndustry.toString()}.pdf',
    );
  }

  // 2. FUNKCJA POBIERANIA (WEB + MOBILE)
  static Future<void> downloadPdf({
    required double roi,
    required double benefit,
    required double marginIncrease,
    required double roiTime,
    required double errorSavings,
    required double migrationSavings,
    required dynamic selectedIndustry,
  }) async {
    final bytes = await _generatePdfContent(
      roi: roi,
      benefit: benefit,
      marginIncrease: marginIncrease,
      roiTime: roiTime,
      errorSavings: errorSavings,
      migrationSavings: migrationSavings,
      selectedIndustry: selectedIndustry,
    );

    final fileName = 'Raport_ROI_${DateTime.now().millisecondsSinceEpoch}.pdf';

    if (kIsWeb) {
      // Logika pobierania dla przeglądarki
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor =
          html.AnchorElement(href: url)
            ..setAttribute('download', fileName)
            ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // Logika zapisu dla telefonu (Android/iOS)
      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) dir = await getExternalStorageDirectory();
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final file = File('${dir!.path}/$fileName');
      await file.writeAsBytes(bytes);
      print('DEBUG: Plik zapisany w: ${file.path}');
    }
  }

  // 3. FUNKCJA UDOSTĘPNIANIA (TYLKO MOBILE)
  static Future<void> sharePdf({
    required double roi,
    required double benefit,
    required double marginIncrease,
    required double roiTime,
    required double errorSavings,
    required double migrationSavings,
    required dynamic selectedIndustry,
  }) async {
    if (kIsWeb) {
      // Udostępnianie plików na Webie natywnym share sheetem bywa problematyczne,
      // więc jako fallback po prostu pobieramy plik.
      await downloadPdf(
        roi: roi,
        benefit: benefit,
        marginIncrease: marginIncrease,
        roiTime: roiTime,
        errorSavings: errorSavings,
        migrationSavings: migrationSavings,
        selectedIndustry: selectedIndustry,
      );
      return;
    }

    final bytes = await _generatePdfContent(
      roi: roi,
      benefit: benefit,
      marginIncrease: marginIncrease,
      roiTime: roiTime,
      errorSavings: errorSavings,
      migrationSavings: migrationSavings,
      selectedIndustry: selectedIndustry,
    );

    // Zapisujemy plik w pamięci tymczasowej, żeby móc go udostępnić
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/Raport_ROI.pdf');
    await file.writeAsBytes(bytes);

    // Wywołanie systemowego okna udostępniania
    await Share.shareXFiles([
      XFile(file.path),
    ], text: 'Cześć! Przesyłam wyliczony raport ROI dla naszej hurtowni.');
  }
}
