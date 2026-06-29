import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kNavy = Color(0xFF0B1E8A);

// ---------- LABEL ----------
Widget appLabel(String text) {
  return Text(
    text,
    style: GoogleFonts.beVietnamPro(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade700,
    ),
  );
}

// ---------- TEXT FIELD ----------
Widget appTextField({
  required TextEditingController controller,
  required String hint,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  Widget? suffix,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: appInputDecoration(hint: hint, icon: icon, suffix: suffix),
  );
}

// ---------- PASSWORD FIELD ----------
Widget appPasswordField({
  required String label,
  required TextEditingController controller,
  required bool obscure,
  required VoidCallback onToggle,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      appLabel(label),
      const SizedBox(height: 6),
      TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.beVietnamPro(fontSize: 14),
        decoration: appInputDecoration(
          hint: '••••••••',
          icon: Icons.key_outlined,
          suffix: IconButton(
            icon: Icon(
              obscure ? Icons.visibility_off : Icons.visibility,
              size: 18,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    ],
  );
}

// ---------- INPUT DECORATION ----------
InputDecoration appInputDecoration({
  String? hint,
  IconData? icon,
  Widget? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: GoogleFonts.beVietnamPro(color: Colors.grey.shade400),
    prefixIcon: icon != null ? Icon(icon, color: Colors.grey.shade500) : null,
    suffixIcon: suffix,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: _kNavy, width: 1.5),
    ),
  );
}

// ---------- TOMBOL BIRU ----------
// Tombol biru yang dipakai di banyak screen
Widget appPrimaryButton({
  required String label,
  required VoidCallback? onPressed,
  bool isLoading = false,
}) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _kNavy,
        disabledBackgroundColor: _kNavy.withOpacity(0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      onPressed: isLoading ? null : onPressed,
      child:
          isLoading
              ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(
                label,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
    ),
  );
}
