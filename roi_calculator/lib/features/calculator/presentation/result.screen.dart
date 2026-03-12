import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:roi_calculator/assets/services/pdf_service.dart';

class ResultScreen extends StatelessWidget {
  final double roi;
  final double benefit;
  final double cost;
  final double orders;
  final double esavings;
  final double msavings;
  final double profit;

  const ResultScreen({
    super.key,
    required this.roi,
    required this.benefit,
    required this.cost,
    required this.orders,
    required this.esavings,
    required this.msavings,
    required this.profit,
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
              value: '450 000 zł',
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              icon: Icons.trending_up,
              iconColor: Colors.green,
              iconBgColor: Colors.green.withOpacity(0.1),
              title: 'ROI (ZWROT Z INWESTYCJI)',
              value: '${roi}%',
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              icon: Icons.access_time,
              iconColor: Colors.orange,
              iconBgColor: Colors.orange.withOpacity(0.1),
              title: 'OKRES ZWROTU',
              value: '5 miesięcy',
            ),
            const SizedBox(height: 24),
            _buildVisualisationCard(),
            const SizedBox(height: 24),
            _buildInfoBox(),
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
            'Wholesale ROI',
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
            downloadPdf(
              roi: roi,
              benefit: benefit,
              cost: cost,
              orders: orders,
              errorSavings: esavings,
              migrationSavings: msavings,
              salesGrowthProfit: profit,
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share_rounded, color: Colors.black54),
          onPressed: () {},
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
          _buildProgressBar('Oszczędność operacyjna', '180 000 zł', 0.45),
          const SizedBox(height: 16),
          _buildProgressBar('Wzrost marży', '210 000 zł', 0.55),
          const SizedBox(height: 16),
          _buildProgressBar('Redukcja błędów', '60 000 zł', 0.15),
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

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Wymagany nakład pracy',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: 13,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text:
                      'Aby osiągnąć ten wynik, Twoi handlowcy muszą przekonać około ',
                ),
                TextSpan(
                  text: '120 ekip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextSpan(
                  text:
                      ' do korzystania z aplikacji (średnio 4 ekipy na handlowca).',
                ),
              ],
            ),
          ),
        ],
      ),
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
          _buildAnalysisRow('Oszczędność\noperacyjna', '180 000 zł'),
          _buildAnalysisRow('Wzrost marży', '210 000 zł'),
          _buildAnalysisRow('Redukcja błędów', '60 000 zł'),
          _buildAnalysisRow(
            'Wartość analityczna',
            'Strategic NPV',
            isBlueValue: true,
          ),
          _buildAnalysisRow(
            'Przewaga\nkonkurencyjna',
            'High Impact',
            isBlueValue: true,
            showDivider: false,
          ),
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
                  '&cost=${cost}'
                  '&orders=${orders}'
                  '&esavings=${esavings}'
                  '&msavings=${msavings}'
                  '&profit=${profit}';

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
            onPressed: () {},
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
            onPressed: () {},
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
          '© 2024 Wholesale ROI Calculator. Wszystkie prawa\nzastrzeżone.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: Colors.grey[500], height: 1.5),
        ),
      ),
    );
  }
}
