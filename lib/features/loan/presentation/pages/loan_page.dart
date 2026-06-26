import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/installment.dart';
import '../../domain/entities/loan.dart';
import '../cubit/loan_cubit.dart';
import '../cubit/loan_state.dart';
import 'simulasi_pinjaman_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoanPage extends StatelessWidget {
  const LoanPage({super.key});

  static const _kDarkRed = Color(0xFF8B0000);
  static const _kRed = Color(0xFFB00000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: Text(
          'Pinjaman',
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: BlocBuilder<LoanCubit, LoanState>(
        builder: (context, state) {
          if (state is LoanLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is LoanError) {
            return Center(
              child: Text(
                state.message,
                style: GoogleFonts.beVietnamPro(color: Colors.red),
              ),
            );
          }
          if (state is LoanLoaded) {
            return _buildContent(context, state.loan);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Loan loan) {
    final summary = loan.summary;
    final progress = summary.paidInstallment / summary.totalInstallment;

    return Column(
      children: [
        // ── GAUGE CARD (FIXED, TIDAK IKUT SCROLL) ────────────────
        Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: _kDarkRed,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.sackDollar,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              // Half circle gauge - untuk sisa pinjaman
              SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(180, 180),
                      painter: _CircleGaugePainter(progress: progress),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sisa Pinjaman',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          summary.remainingLoan.toRupiah(),
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: _kRed,
                          ),
                        ),
                        Text(
                          'Dari ${summary.totalLoan.toRupiah()}',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tombol
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: _kRed),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Lunasi Semua',
                        style: GoogleFonts.beVietnamPro(color: _kRed),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SimulasiPinjamanPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Simulasi',
                        style: GoogleFonts.beVietnamPro(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // ── BAGIAN BAWAH: HANYA INI YANG BISA DI-SCROLL ──────────
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    color: const Color(0xFFECFDF5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Color(0xFF059669),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Sudah membayar ${summary.paidInstallment} '
                            'dari total ${summary.totalInstallment} cicilan',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: const Color(0xFF059669),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // -------------- ROW INFORMASI ---------------------------
                  _infoRow('Pembayaran Selanjutnya', summary.nextPaymentDate),
                  Divider(color: Colors.grey.shade100, height: 1),
                  _infoRow(
                    'Pokok Hutang Dibayar',
                    summary.principalPaid.toRupiah(),
                  ),

                  Divider(color: Colors.grey.shade200, height: 1, thickness: 6),

                  // --------------- HISTORY TAGIHAN ------------------------
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'History Tagihan',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: loan.installments.length,
                    itemBuilder: (_, i) {
                      final reversed = loan.installments.reversed.toList();
                      return _installmentItem(
                        reversed[i],
                        loan.summary.totalInstallment,
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _installmentItem(Installment trx, int total) {
    final isPaid = trx.status == 'paid';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cicilan ${trx.installmentNo} dari $total',
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    trx.date,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    trx.amount.toRupiah(),
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isPaid ? Colors.black87 : Colors.grey,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isPaid
                              ? const Color(0xFFECFDF5)
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isPaid ? 'Lunas' : 'Belum ada tagihan',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isPaid ? const Color(0xFF059669) : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade100,
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}

// ── FULL CIRCLE GAUGE PAINTER ──────────────────────────────────────────────────
class _CircleGaugePainter extends CustomPainter {
  final double progress;
  const _CircleGaugePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeW = 14.0;

    final bgPaint =
        Paint()
          ..color = Colors.red.shade100
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round;

    final fgPaint =
        Paint()
          ..color = const Color(0xFFB00000)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeW
          ..strokeCap = StrokeCap.round;

    final rect = Rect.fromCircle(center: center, radius: radius);

    const startAngle = 150 * math.pi / 180;
    const sweepFull = 240 * math.pi / 180;

    canvas.drawArc(rect, startAngle, sweepFull, false, bgPaint);
    canvas.drawArc(rect, startAngle, sweepFull * progress, false, fgPaint);
  }

  @override
  bool shouldRepaint(_CircleGaugePainter old) => old.progress != progress;
}
