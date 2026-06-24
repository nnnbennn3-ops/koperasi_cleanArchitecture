import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../cubit/simpanan_cubit.dart';
import '../cubit/simpanan_state.dart';
import '../../domain/entities/simpanan.dart';

class SimpananWajibPage extends StatelessWidget {
  const SimpananWajibPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SimpananCubit>()..fetch(type: 'wajib'),
      child: const _SimpananWajibView(),
    );
  }
}

class _SimpananWajibView extends StatelessWidget {
  const _SimpananWajibView();

  static const _kNavy = Color(0xFF0D1461);
  static const _months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_months[d.month]} ${d.year}, '
      '${d.hour.toString().padLeft(2, '0')}.${d.minute.toString().padLeft(2, '0')}';

  String _monthLabel(DateTime d) => '${_months[d.month]} ${d.year}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: BlocBuilder<SimpananCubit, SimpananState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              //--------- APP BAR -------------------
              SliverAppBar(
                backgroundColor: const Color(0xFFF5F6FA),
                foregroundColor: Colors.black87,
                elevation: 0,
                floating: true,
                title: Text(
                  'Simpanan Wajib',
                  style: GoogleFonts.beVietnamPro(
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (state is SimpananLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is SimpananError)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (state is SimpananLoaded) ...[
                //----------------- SALDO AREA ----------------------
                SliverToBoxAdapter(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(height: 120, color: const Color(0xFFEEF0FB)),
                      Positioned(
                        left: 40,
                        right: 40,
                        top: 20,
                        child: Column(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: _kNavy,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.receipt_long,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(
                                24,
                                20,
                                24,
                                24,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  state.simpanan.balance.toRupiah(),
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: _kNavy,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 82)),

                // ------------------- HISTORY SECTION ----------------------
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'History',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        //Outgoing/Incoming dari data
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Ambil bulan dari transaksi terbaru
                              Text(
                                state.simpanan.transactions.isNotEmpty
                                    ? _monthLabel(
                                      state.simpanan.transactions.first.date,
                                    )
                                    : '',
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Outgoing: ${state.simpanan.totalOutgoing.toRupiah()}',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Incoming:  ${state.simpanan.totalIncoming.toRupiah()}',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) => Container(
                      color: Colors.white,
                      child: _historyItem(state.simpanan.transactions[i]),
                    ),
                    childCount: state.simpanan.transactions.length,
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _historyItem(SimpananTransactionEntity trx) {
    final isCredit = trx.isCredit;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFEEF0FB),
                child: Icon(
                  isCredit
                      ? Icons.arrow_downward_rounded
                      : Icons.arrow_upward_rounded,
                  color: _kNavy,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trx.title,
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _formatDate(trx.date),
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isCredit ? "+" : "-"}${trx.amount.toRupiah()}',
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: isCredit ? const Color(0xFF2E7D32) : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade100,
          height: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
