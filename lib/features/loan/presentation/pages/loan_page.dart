import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/loan.dart';
import '../cubit/loan_cubit.dart';
import '../cubit/loan_state.dart';
import 'package:clean_architecture/features/loan/presentation/pages/simulasi_pinjaman_page.dart';

class LoanPage extends StatelessWidget {
  const LoanPage({super.key});

  String rupiah(double v) {
    return 'Rp ${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}'; //konversi ke format rupiah
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: AppBar(
        title: Text(
          'Pinjaman',
          style: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<LoanCubit, LoanState>(
        builder: (context, state) {
          if (state is LoanLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoanLoaded) {
            final loan = state.loan;
            return Column(
              children: [
                _ringkasan(context, loan),
                const SizedBox(height: 12),
                _infoSection(loan),
                const SizedBox(height: 8),
                Expanded(child: _historySection(loan)),
              ],
            );
          }

          if (state is LoanError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  //Widget Ringkasan Pinjeman
  Widget _ringkasan(BuildContext context, Loan loan) {
    final summary = loan.summary;
    final progress = summary.paidInstallment / summary.totalInstallment;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.red.shade100,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFB00000),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      'Sisa Pinjaman',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      rupiah(summary.remainingLoan),
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFB00000),
                      ),
                    ),
                    Text(
                      'Dari ${rupiah(summary.totalLoan)}',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'Lunasi Semua',
                      style: GoogleFonts.beVietnamPro(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB00000),
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
    );
  }

  // ----- INFO -----
  Widget _infoSection(Loan loan) {
    final summary = loan.summary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _infoRow(
            'Sudah Membayar',
            '${summary.paidInstallment} dari total ${summary.totalInstallment} cicilan',
          ),
          _infoRow('Pembayaran Selanjutnya', summary.nextPaymentDate),
          _infoRow('Pokok Hutang Dibayar', rupiah(summary.principalPaid)),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
            ),
          ),
        ],
      ),
    );
  }

  // ----- HISTORY -----
  Widget _historySection(Loan loan) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ListView.builder(
        itemCount: loan.installments.length,
        itemBuilder: (context, index) {
          final trx = loan.installments[index];
          final lunas = trx.status == 'paid';

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cicilan ${trx.installmentNo} dari ${loan.summary.totalInstallment}',
                          style: GoogleFonts.beVietnamPro(
                            fontWeight: FontWeight.w600,
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
                          rupiah(trx.amount),
                          style: GoogleFonts.beVietnamPro(
                            color: lunas ? Colors.black : Colors.grey,
                          ),
                        ),
                        Text(
                          lunas ? 'Lunas' : 'Belum ada tagihan',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 12,
                            color: lunas ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
