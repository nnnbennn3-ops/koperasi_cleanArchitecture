import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpananSukarelaPage extends StatelessWidget {
  const SimpananSukarelaPage({super.key});

  String formatCurrency(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (m) => ".",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: AppBar(
        title: const Text("Simpanan Sukarela"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          /// SALDO CARD
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.description, color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Rp ${formatCurrency(2000000)}",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// HISTORY CONTAINER
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 16),

                  /// HEADER HISTORY
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History",
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Outgoing: Rp ${formatCurrency(175000)}",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              "Incoming: Rp ${formatCurrency(600000)}",
                              style: GoogleFonts.beVietnamPro(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// LIST HISTORY
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _historyItem("SHU", "02 Jun 2025, 09.15", 500000, true),
                        _historyItem(
                          "Setoran Dana",
                          "25 Jun 2025, 09.15",
                          150000,
                          true,
                        ),
                        _historyItem(
                          "Setoran Dana",
                          "25 May 2025, 09.15",
                          150000,
                          true,
                        ),
                        _historyItem(
                          "Setoran Dana",
                          "25 Apr 2025, 09.15",
                          150000,
                          true,
                        ),
                        _historyItem(
                          "Setoran Dana",
                          "25 Feb 2025, 09.15",
                          150000,
                          true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _historyItem(String title, String date, int amount, bool isPositive) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue.withOpacity(0.1),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      date,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "+Rp ${formatCurrency(amount)}",
                style: GoogleFonts.beVietnamPro(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade200),
      ],
    );
  }
}
