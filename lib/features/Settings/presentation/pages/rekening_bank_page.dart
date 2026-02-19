import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RekeningBankPage extends StatefulWidget {
  const RekeningBankPage({super.key});

  @override
  State<RekeningBankPage> createState() => _RekeningBankPageState();
}

class _RekeningBankPageState extends State<RekeningBankPage> {
  final bankController = TextEditingController(text: "BCA");
  final rekeningController = TextEditingController(text: "667788345");
  final namaController = TextEditingController(text: "Joe Mama");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: AppBar(
        title: Text(
          "Rekening Bank",
          style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textField(
              "Nama Bank",
              bankController,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
            const SizedBox(height: 16),
            _textField("Nomor Rekening", rekeningController),
            const SizedBox(height: 16),
            _textField("Nama Lengkap", namaController),
            const Spacer(),
            _primaryButton("Simpan"),
          ],
        ),
      ),
    );
  }

  Widget _textField(
    String label,
    TextEditingController controller, {
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 13,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: GoogleFonts.beVietnamPro(fontSize: 14),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

  Widget _primaryButton(String text) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00006F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.beVietnamPro(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
