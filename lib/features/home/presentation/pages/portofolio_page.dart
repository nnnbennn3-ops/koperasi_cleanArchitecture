import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/portofolio_model.dart';

import 'package:clean_architecture/features/loan/data/datasources/loan_local_datasource.dart';
import 'package:clean_architecture/features/loan/data/repositories/loan_repository_impl.dart';
import 'package:clean_architecture/features/loan/domain/usecases/get_loan.dart';
import 'package:clean_architecture/features/loan/presentation/cubit/loan_cubit.dart';
import 'package:clean_architecture/features/loan/presentation/pages/loan_page.dart';

import 'package:clean_architecture/features/home/presentation/pages/simpanan/simpanan_wajib_page.dart';
import 'package:clean_architecture/features/home/presentation/pages/simpanan/simpanan_sukarela_page.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  int totalSaldo = 0;
  List<PortofolioItem> items = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final response = await rootBundle.loadString('assets/data/portofolio.json');
    final data = json.decode(response);

    setState(() {
      totalSaldo = data['total_saldo'];
      items =
          (data['items'] as List)
              .map((e) => PortofolioItem.fromJson(e))
              .toList();
    });
  }

  void navigate(String type) {
    if (type == "wajib") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpananWajibPage()),
      );
    } else if (type == "sukarela") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SimpananSukarelaPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            final dataSource = LoanLocalDataSource();
            final repository = LoanRepositoryImpl(dataSource);
            final usecase = GetLoan(repository);

            return BlocProvider(
              create: (_) => LoanCubit(usecase)..fetchLoan(),
              child: const LoanPage(),
            );
          },
        ),
      );
    }
  }

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
        title: const Text("Portofolio"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body:
          items.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    /// TOTAL SALDO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Saldo",
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          "Rp ${formatCurrency(totalSaldo)}",
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// LIST CARD
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return _buildCard(item);
                        },
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildCard(PortofolioItem item) {
    final isWajib = item.type == "wajib";
    final isSukarela = item.type == "sukarela";
    final isPinjaman = item.type == "pinjaman";

    return GestureDetector(
      onTap: () => navigate(item.type),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color:
              isWajib
                  ? Colors.white
                  : isSukarela
                  ? const Color(0xFF0D1A8F)
                  : const Color(0xFFB00000),
          borderRadius: BorderRadius.circular(20),
          border: isWajib ? Border.all(color: Colors.blue.shade200) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: isWajib ? Colors.black : Colors.white,
                  ),
                ),
                const SizedBox(height: 6),

                if (isPinjaman)
                  Text(
                    "Sisa Pinjaman",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),

                Text(
                  "Rp ${formatCurrency(item.total)}",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isWajib ? Colors.black : Colors.white,
                  ),
                ),

                if (isPinjaman)
                  Text(
                    "Tanggal Cicilan\n15 Jun 2025",
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),

                const SizedBox(height: 8),

                Text(
                  "Lihat Detail →",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 12,
                    color: isWajib ? Colors.blue : Colors.white70,
                  ),
                ),
              ],
            ),

            Positioned(
              right: 0,
              bottom: 0,
              child: isPinjaman ? _progressCircle() : _iconBox(isWajib),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBox(bool isWajib) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isWajib ? Colors.blue : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isWajib ? Icons.description : Icons.account_balance_wallet,
        color: isWajib ? Colors.white : const Color(0xFF0D1A8F),
      ),
    );
  }

  Widget _progressCircle() {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: 0.5,
            strokeWidth: 3,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          Text(
            "50%",
            style: GoogleFonts.beVietnamPro(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
