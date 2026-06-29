import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../cubit/simpanan_cubit.dart';
import '../cubit/simpanan_state.dart';
import '../../domain/entities/simpanan_entity.dart';

class SimpananSukarelaPage extends StatelessWidget {
  const SimpananSukarelaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SimpananCubit>()..fetch(type: 'sukarela'),
      child: const _SimpananSukarelaView(),
    );
  }
}

class _SimpananSukarelaView extends StatelessWidget {
  const _SimpananSukarelaView();

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
      backgroundColor: const Color(0xFFEEF0FB),
      body: BlocBuilder<SimpananCubit, SimpananState>(
        builder: (context, state) {
          if (state is SimpananLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SimpananError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is SimpananLoaded) {
            return Stack(
              children: [
                // ── FIXED AREA ──────────────────────────────────
                Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            BackButton(color: Colors.black87),
                            Text(
                              'Simpanan Sukarela',
                              style: GoogleFonts.beVietnamPro(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
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
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
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

                // ── DRAGGABLE HISTORY ────────────────────────────
                DraggableScrollableSheet(
                  initialChildSize: 0.52,
                  minChildSize: 0.52,
                  maxChildSize: 1.0,
                  builder: (_, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 8,
                                ),
                                width: 40,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),

                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'History',
                                    style: GoogleFonts.beVietnamPro(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.simpanan.transactions.isNotEmpty
                                            ? _monthLabel(
                                              state
                                                  .simpanan
                                                  .transactions
                                                  .first
                                                  .date,
                                            )
                                            : '',
                                        style: GoogleFonts.beVietnamPro(
                                          fontSize: 13,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Outgoing:  ${state.simpanan.totalOutgoing.toRupiah()}',
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
                                ],
                              ),
                            ),
                          ),

                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) =>
                                  _historyItem(state.simpanan.transactions[i]),
                              childCount: state.simpanan.transactions.length,
                            ),
                          ),

                          const SliverToBoxAdapter(child: SizedBox(height: 32)),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          }
          return const SizedBox();
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
