import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> downloadPdf({
  required double roi,
  required double benefit,
  required double cost,
  required double orders,
  required double errorSavings,
  required double migrationSavings,
  required double salesGrowthProfit,
}) async {

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(32),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text(
                "ROI Report",
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text("ROI: ${roi.toStringAsFixed(2)}%"),
              pw.Text("Benefit: ${benefit.toStringAsFixed(0)} PLN"),
              pw.Text("Cost: ${cost.toStringAsFixed(0)} PLN"),
              pw.Text("Orders: ${orders.toStringAsFixed(0)}"),

              pw.SizedBox(height: 20),

              pw.Text("Error savings: ${errorSavings.toStringAsFixed(0)} PLN"),
              pw.Text("Migration savings: ${migrationSavings.toStringAsFixed(0)} PLN"),
              pw.Text("Sales growth profit: ${salesGrowthProfit.toStringAsFixed(0)} PLN"),

            ],
          ),
        );
      },
    ),
  );

  await Printing.sharePdf(
    bytes: await pdf.save(),
    filename: 'roi_report.pdf',
  );
}