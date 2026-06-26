import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';

class RekeningBankPage extends StatefulWidget {
  final String bankName;
  final String accountNumber;
  final String accountName;

  const RekeningBankPage({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
  });

  @override
  State<RekeningBankPage> createState() => _RekeningBankPageState();
}

class _RekeningBankPageState extends State<RekeningBankPage> {
  late final TextEditingController _bankController;
  late final TextEditingController _rekeningController;
  late final TextEditingController _namaController;

  //Opsi bank
  final List<String> _bankOptions = [
    'BCA',
    'BRI',
    'BNI',
    'Mandiri',
    'CIMB',
    'Permata',
    'Danamon',
  ];

  @override
  void initState() {
    super.initState();
    _bankController = TextEditingController(text: widget.bankName);
    _rekeningController = TextEditingController(text: widget.accountNumber);
    _namaController = TextEditingController(text: widget.accountName);
  }

  @override
  void dispose() {
    _bankController.dispose();
    _rekeningController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  void _onSave() {
    context.read<SettingsCubit>().saveBank(
      bank: _bankController.text.trim(),
      account: _rekeningController.text.trim(),
      name: _namaController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text(
          'Rekening Bank',
          style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocListener<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is SettingsUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            }
            if (state is SettingsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red.shade700,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ----------------- Nama Bank ----------------------
                _buildLabel('Nama Bank'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value:
                      _bankOptions.contains(_bankController.text)
                          ? _bankController.text
                          : _bankOptions.first,
                  decoration: _inputDecoration(),
                  items:
                      _bankOptions
                          .map(
                            (b) => DropdownMenuItem(value: b, child: Text(b)),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) _bankController.text = val;
                  },
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 16),

                // ----------------- Nomor Rekening -----------------------
                _buildLabel('Nomor Rekening'),
                const SizedBox(height: 6),
                TextField(
                  controller: _rekeningController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.beVietnamPro(fontSize: 14),
                  decoration: _inputDecoration(),
                ),

                const SizedBox(height: 16),

                // -------------------- Nama Lengkap -----------------------
                _buildLabel('Nama Lengkap'),
                const SizedBox(height: 6),
                TextField(
                  controller: _namaController,
                  style: GoogleFonts.beVietnamPro(fontSize: 14),
                  decoration: _inputDecoration(),
                ),

                const Spacer(),

                // -------------------- Tombol Simpanan ---------------------
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final isLoading = state is SettingsUpdateLoading;
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B1E8A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: isLoading ? null : _onSave,
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
                                  'Simpan',
                                  style: GoogleFonts.beVietnamPro(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.beVietnamPro(
          fontSize: 13,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
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
        borderSide: const BorderSide(color: Color(0xFF0B1E8A), width: 1.5),
      ),
    );
  }
}
