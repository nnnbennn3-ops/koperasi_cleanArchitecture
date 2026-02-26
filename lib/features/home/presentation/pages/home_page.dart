import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../../domain/entities/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHidden = false;

  String rupiah(double value) {
    return "Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ".")}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeLoaded) {
              final home = state.home;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // ================= HEADER =================
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage("assets/profil.jpg"),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, Joe Mama!",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "167168",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ================= SALDO CARD =================
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3A0CA3), Color(0xFF7209B7)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Saldo",
                            style: GoogleFonts.beVietnamPro(
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                isHidden ? "Rp ••••••••" : rupiah(home.total),
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isHidden = !isHidden;
                                  });
                                },
                                child: Icon(
                                  isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Simpanan Wajib",
                                    style: GoogleFonts.beVietnamPro(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    isHidden ? "••••••" : rupiah(home.wajib),
                                    style: GoogleFonts.beVietnamPro(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Simpanan Sukarela",
                                    style: GoogleFonts.beVietnamPro(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    isHidden ? "••••••" : rupiah(home.sukarela),
                                    style: GoogleFonts.beVietnamPro(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      "Riwayat Transaksi",
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ================= TRANSACTION SUMMARY =================
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverPersistentHeader(
                            floating: true,
                            delegate: _SummaryHeaderDelegate(
                              minHeight: 70,
                              maxHeight: 70,
                              child: Container(
                                color: const Color(0xFFF3F4F6),
                                padding: const EdgeInsets.symmetric(
                                  // horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Feb ${DateTime.now().year}",
                                      style: GoogleFonts.beVietnamPro(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Outgoing: ${rupiah(home.withdraw)}",
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          "Incoming: ${rupiah(home.deposit)}",
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          PagedSliverList<int, TransactionEntity>(
                            pagingController:
                                context.read<HomeCubit>().pagingController,
                            builderDelegate: PagedChildBuilderDelegate<
                              TransactionEntity
                            >(
                              itemBuilder: (context, trx, index) {
                                final isDeposit = trx.type == "deposit";

                                final previousTrx =
                                    index > 0
                                        ? context
                                            .read<HomeCubit>()
                                            .pagingController
                                            .itemList![index - 1]
                                        : null;

                                final isNewMonth =
                                    previousTrx == null ||
                                    (trx.date.year != previousTrx.date.year ||
                                        trx.date.month !=
                                            previousTrx.date.month);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (isNewMonth) ...[
                                      if (index > 0) const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 16,
                                        ),
                                        child: Text(
                                          "${_monthName(trx.date.month)} ${trx.date.year}",
                                          style: GoogleFonts.beVietnamPro(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              isDeposit
                                                  ? Colors.green.shade50
                                                  : Colors.red.shade50,
                                          child: Icon(
                                            isDeposit
                                                ? Icons.arrow_downward
                                                : Icons.arrow_upward,
                                            color:
                                                isDeposit
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                trx.title,
                                                style: GoogleFonts.beVietnamPro(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "${trx.date.day.toString().padLeft(2, '0')} ${_monthName(trx.date.month)} ${trx.date.year}",
                                                style: GoogleFonts.beVietnamPro(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${isDeposit ? "+" : "-"}${rupiah(trx.amount)}",
                                          style: GoogleFonts.beVietnamPro(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                isDeposit
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(height: 24),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      "",
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "Mei",
      "Jun",
      "Jul",
      "Agu",
      "Sep",
      "Okt",
      "Nov",
      "Des",
    ];
    return months[month];
  }
}

class _SummaryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SummaryHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SummaryHeaderDelegate oldDelegate) {
    return true;
  }
}
