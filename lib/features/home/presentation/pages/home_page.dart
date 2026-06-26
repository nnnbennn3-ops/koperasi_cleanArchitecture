import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/home.dart';
import '../../domain/entities/transaction.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isHidden = false;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _headerKey = GlobalKey();
  final Map<String, GlobalKey> _groupKeys = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final box = _headerKey.currentContext?.findRenderObject() as RenderBox?;
    final headerHeight = box?.size.height ?? 100;
    context.read<HomeCubit>().evaluatePinnedMonth(
      _scrollController.offset,
      headerHeight: headerHeight,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_months[date.month]} '
        '${date.year}, '
        '${date.hour.toString().padLeft(2, '0')}.'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  IconData _iconForTransaction(String title) {
    final t = title.toLowerCase();
    if (t.contains('shu')) {
      return Icons.monetization_on_outlined;
    }
    if (t.contains('penarikan')) {
      return Icons.arrow_upward;
    }
    if (t.contains('setoran')) {
      return Icons.arrow_downward;
    }
    if (t.contains('indomaret') || t.contains('kopkar')) {
      return Icons.receipt_outlined;
    }
    return Icons.swap_horiz;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      buildWhen: (prev, curr) => curr is! HomeMonthChanged,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: GoogleFonts.beVietnamPro(color: Colors.red),
              ),
            ),
          );
        }

        if (state is HomeLoaded) {
          final home = state.home;
          final groups = HomeCubit.groupByMonth(home.transactions);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final cubit = context.read<HomeCubit>();
            for (final group in groups) {
              final key = _groupKeys.putIfAbsent(group.key, () => GlobalKey());
              cubit.registerMonthKey(group.key, key, group);
            }
          });

          return Scaffold(
            backgroundColor: const Color(0xFFF3F4F6),
            body: Column(
              children: [
                // ── FIXED HEADER ──────────────────────────────────────
                _buildFixedHeader(home),

                // ── SCROLLABLE AREA ────────────────────────────────────
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                          child: Text(
                            'Riwayat Transaksi',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // Sticky month header
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (prev, curr) => curr is HomeMonthChanged,
                        builder: (context, state) {
                          final month =
                              state is HomeMonthChanged ? state.month : '';
                          final group =
                              state is HomeMonthChanged ? state.group : null;

                          return SliverPersistentHeader(
                            pinned: month.isNotEmpty,
                            delegate: _MonthHeaderDelegate(
                              month: month,
                              group: group,
                            ),
                          );
                        },
                      ),

                      ...groups.map((group) {
                        final key = _groupKeys.putIfAbsent(
                          group.key,
                          () => GlobalKey(),
                        );
                        return _buildMonthGroup(group, key);
                      }),
                      const SliverToBoxAdapter(child: SizedBox(height: 32)),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }

  SliverToBoxAdapter _buildMonthGroup(MonthGroup group, GlobalKey key) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            key: key,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              group.label,
              style: GoogleFonts.beVietnamPro(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade500,
              ),
            ),
          ),
          ...group.transactions.map(
            (trx) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildTransactionItem(trx),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixedHeader(HomeEntity home) {
    return Container(
      key: _headerKey,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 38, 5, 146),
            Color.fromARGB(255, 55, 97, 210),
            Color.fromARGB(255, 195, 193, 206),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 52, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/profil.jpg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, ${home.userName}!',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    home.memberId,
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1461),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Saldo',
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          _isHidden ? 'Rp ••••••••' : home.total.toRupiah(),
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => setState(() => _isHidden = !_isHidden),
                          child: Icon(
                            _isHidden ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white54,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 98, 102, 158),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  border: Border(
                    left: BorderSide(color: Colors.white.withOpacity(0.1)),
                    right: BorderSide(color: Colors.white.withOpacity(0.1)),
                    bottom: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _saldoItem(
                        label: 'Simpanan Wajib',
                        value: _isHidden ? 'Rp ••••••' : home.wajib.toRupiah(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _saldoItem(
                          label: 'Simpanan Sukarela',
                          value:
                              _isHidden
                                  ? 'Rp  ••••••'
                                  : home.sukarela.toRupiah(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(TransactionEntity trx) {
    final isDeposit = trx.type == 'deposit';
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _iconForTransaction(trx.title),
                  size: 20,
                  color: const Color(0xFF0B1E8A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trx.title,
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatDate(trx.date),
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isDeposit ? "+" : "-"}${trx.amount.toRupiah()}',
                style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color:
                      isDeposit ? Colors.green.shade600 : Colors.red.shade500,
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade200),
      ],
    );
  }

  Widget _saldoItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(color: Colors.white60, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}

// ── STICKY MONTH HEADER DELEGATE ──────────────────────────────────────────────
class _MonthHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String month;
  final MonthGroup? group;

  _MonthHeaderDelegate({required this.month, required this.group});

  @override
  double get minExtent => month.isEmpty ? 0 : 52;

  @override
  double get maxExtent => month.isEmpty ? 0 : 52;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (month.isEmpty) return const SizedBox.shrink();

    return Container(
      color: const Color(0xFFF3F4F6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            month,
            style: GoogleFonts.beVietnamPro(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (group != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Outgoing: -${group!.withdraw.toRupiah()}',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Incoming: +${group!.deposit.toRupiah()}',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_MonthHeaderDelegate old) =>
      old.month != month || old.group != group;
}
