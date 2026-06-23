import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/currency_formatter.dart';

class SimulasiPinjamanPage extends StatefulWidget {
  const SimulasiPinjamanPage({super.key});

  @override
  State<SimulasiPinjamanPage> createState() => _SimulasiPinjamanPageState();
}

class _SimulasiPinjamanPageState extends State<SimulasiPinjamanPage> {
  double _jumlahPinjaman = 3000000;
  double _tenor = 6;

  static const double _bungaPerBulan = 0.01;

  double get _cicilanBulanan {
    if (_jumlahPinjaman == 0) return 0;
    final totalBunga = _jumlahPinjaman * _bungaPerBulan * _tenor;
    return (_jumlahPinjaman + totalBunga) / _tenor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8B0000), Color(0xFFD46565), Colors.white],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      _buildSliderCard(
                        title: 'Jumlah Pinjaman',
                        valueText: _jumlahPinjaman.toRupiah(),
                        slider: Slider(
                          value: _jumlahPinjaman,
                          min: 100000,
                          max: 10000000,
                          divisions: 99,
                          onChanged: (v) => setState(() => _jumlahPinjaman = v),
                        ),
                      ),
                      _buildSliderCard(
                        title: 'Tenor (bulan)',
                        valueText: _tenor.toInt().toString(),
                        slider: Slider(
                          value: _tenor,
                          min: 1,
                          max: 48,
                          divisions: 48,
                          onChanged: (v) => setState(() => _tenor = v),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                'Simulasi Pinjaman',
                style: GoogleFonts.beVietnamPro(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Perkiraan Cicilan Kamu',
            style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            '${_cicilanBulanan.toRupiah()}/Bulan',
            style: GoogleFonts.beVietnamPro(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Selama ${_tenor.toInt()} Bulan',
            style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            '*Perhitungan dengan suku bunga 1% flat per bulan',
            style: GoogleFonts.beVietnamPro(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderCard({
    required String title,
    required String valueText,
    required Widget slider,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.beVietnamPro(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            valueText,
            style: GoogleFonts.beVietnamPro(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 20),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              activeTrackColor: const Color(0xFF0D1461),
              inactiveTrackColor: Colors.blue.shade100,
              thumbColor: const Color(0xFF0D1461),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            ),
            child: slider,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0XFF0D1461),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Oke, kembali ke pinjaman',
            style: GoogleFonts.beVietnamPro(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
