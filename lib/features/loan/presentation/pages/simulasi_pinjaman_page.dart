import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimulasiPinjamanPage extends StatefulWidget {
  const SimulasiPinjamanPage({super.key});

  @override
  State<SimulasiPinjamanPage> createState() => _SimulasiPinjamanPageState();
}

class _SimulasiPinjamanPageState extends State<SimulasiPinjamanPage> {
  double jumlahPinjaman = 0;
  double tenor = 10;

  final double bungaPerBulan = 0.01; // 1% flat per bulan

  double cicilanBulanan() {
    final totalBunga = jumlahPinjaman * bungaPerBulan * tenor;
    return (jumlahPinjaman + totalBunga) / tenor;
  }

  String rupiah(num value) {
    return 'Rp ${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF8B0000), // merah atas
            Color.fromARGB(255, 215, 101, 101), // transisi
            Colors.white, // putih bawah
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Transform.translate(
                  offset: const Offset(0, -10),
                  child: Column(
                    children: [_cardJumlahPinjaman(), _cardTenor()],
                  ),
                ),
              ),
            ),
            _buttonKembali(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER MERAH =================

  Widget _header() {
    return SizedBox(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 56, 24, 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B0000), Color(0xFFB00000)],
          ),
        ),
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Perkiraan Cicilan kamu',
              style: GoogleFonts.beVietnamPro(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${rupiah(cicilanBulanan())}/Bulan',
              style: GoogleFonts.beVietnamPro(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Selama ${tenor.toInt()} Bulan',
              style: GoogleFonts.beVietnamPro(
                color: Colors.white,
                fontSize: 23,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '*Perhitungan dengan suku bunga 1%\nflat per bulan',
              style: GoogleFonts.beVietnamPro(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= CARD JUMLAH PINJAMAN =================

  Widget _cardJumlahPinjaman() {
    return _sliderCard(
      title: 'Jumlah Pinjaman',
      valueText: rupiah(jumlahPinjaman),
      slider: Slider(
        value: jumlahPinjaman,
        min: 0,
        max: 10000000,
        divisions: 100,
        onChanged: (v) => setState(() => jumlahPinjaman = v),
      ),
    );
  }

  // ================= CARD TENOR =================
  Widget _cardTenor() {
    return _sliderCard(
      title: 'Tenor (bulan)',
      valueText: tenor.toInt().toString(),
      slider: Slider(
        value: tenor,
        min: 1,
        max: 48,
        divisions: 47,
        onChanged: (v) => setState(() => tenor = v),
      ),
    );
  }

  // ================= TEMPLATE CARD =================

  Widget _sliderCard({
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
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            valueText,
            style: GoogleFonts.beVietnamPro(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(height: 24),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              activeTrackColor: const Color(0xFF1E3A8A),
              inactiveTrackColor: Colors.blue.shade400,
              thumbColor: const Color(0xFF1E3A8A),
            ),
            child: slider,
          ),
        ],
      ),
    );
  }

  // ================= BUTTON BAWAH =================

  Widget _buttonKembali() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00006F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Oke, kembali ke pinjaman',
            style: GoogleFonts.beVietnamPro(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
