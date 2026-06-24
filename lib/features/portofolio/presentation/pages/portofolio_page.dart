import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/portofolio_item.dart';
import '../../../simpanan/presentation/pages/simpanan_wajib_page.dart';
import '../../../simpanan/presentation/pages/simpanan_sukarela_page.dart';
import 'package:clean_architecture/features/loan/presentation/cubit/loan_cubit.dart';
import 'package:clean_architecture/features/loan/presentation/pages/loan_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PortfolioPage extends StatelessWidget {
  final List<PortofolioItemEntity> items;
  final double totalSaldo;

  const PortfolioPage({
    super.key,
    required this.items,
    required this.totalSaldo,
  });

  static const _kNavy = Color(0xFF0D1461);
  static const _kDarkRed = Color(0xFF8B0000);

  void _navigate(BuildContext context, String type) {
    if (type == 'wajib') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpananWajibPage()),
      );
    } else if (type == 'sukarela') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpananSukarelaPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => GetIt.instance<LoanCubit>()..fetchLoan(),
                child: const LoanPage(),
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- TITLE --------------
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                'Portofolio',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),

            //--------------- TOTAL SALDO -------------------
            Container(
              margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F1F8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Saldo',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      color: _kNavy,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    totalSaldo.toRupiah(),
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            //---------------- CARD LIST ---------------------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: items.length,
                itemBuilder: (_, i) => _buildCard(context, items[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, PortofolioItemEntity item) {
    switch (item.type) {
      case 'wajib':
        return _wajibCard(context, item);
      case 'sukarela':
        return _sukarelaCard(context, item);
      case 'pinjaman':
        return _pinjamanCard(context, item);
      default:
        return const SizedBox();
    }
  }

  //--------------------- SIMPANAN WAJIB ------------------------
  Widget _wajibCard(BuildContext context, PortofolioItemEntity item) {
    return GestureDetector(
      onTap: () => _navigate(context, 'wajib'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade100, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.total.toRupiah(),
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat Detail →',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _kNavy,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.receipt_long,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------- SIMPANAN SUKARELA --------------------------
  Widget _sukarelaCard(BuildContext context, PortofolioItemEntity item) {
    return GestureDetector(
      onTap: () => _navigate(context, 'sukarela'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kNavy,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _kNavy.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.total.toRupiah(),
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lihat Detail →',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------ PINJAMAN -----------------------------
  Widget _pinjamanCard(BuildContext context, PortofolioItemEntity item) {
    const progress = 0.5;

    return GestureDetector(
      onTap: () => _navigate(context, 'pinjaman'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _kDarkRed,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _kDarkRed.withOpacity(0.35),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sisa Pinjaman',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    item.total.toRupiah(),
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tanggal Cicilan',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                  Text(
                    '15 Jun 2025',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Lihat Detail →',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                const FaIcon(FontAwesomeIcons.sackDollar, color: Colors.white),
                const SizedBox(height: 15),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(80, 80),
                        painter: _CirclePainter(progress: progress),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: GoogleFonts.beVietnamPro(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// LINGKARAN
class _CirclePainter extends CustomPainter {
  final double progress;
  const _CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeW = 6.0;

    final bgPaint =
        Paint()
          ..color = Colors.white24
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round;

    final fgPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(_CirclePainter old) => old.progress != progress;
}
