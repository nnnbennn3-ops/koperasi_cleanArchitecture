import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clean_architecture/core/widgets/app_input_widgets.dart';
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
        title: const Text('Rekening Bank'),
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
                // ---------- NAMA BANK (Dropdown) ----------
                appLabel('Nama Bank'),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value:
                      _bankOptions.contains(_bankController.text)
                          ? _bankController.text
                          : _bankOptions.first,
                  decoration: appInputDecoration(),
                  items:
                      _bankOptions
                          .map(
                            (b) => DropdownMenuItem(
                              value: b,
                              child: Text(
                                b,
                                style: GoogleFonts.beVietnamPro(fontSize: 14),
                              ),
                            ),
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

                // ---------- Nomor Rekening ----------
                appLabel('Nomor Rekening'),
                const SizedBox(height: 6),
                appTextField(
                  controller: _rekeningController,
                  hint: 'Masukkan nomor rekening',
                  icon: Icons.credit_card,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 16),

                // ---------- Nama Lengkap -----------
                appLabel('Nama Lengkap'),
                const SizedBox(height: 6),
                appTextField(
                  controller: _namaController,
                  hint: 'Masukkan nama lengkap',
                  icon: Icons.person_outline,
                ),

                const Spacer(),

                // ---------- Tombol Simpan ----------
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    return appPrimaryButton(
                      label: 'Simpan',
                      onPressed: _onSave,
                      isLoading: state is SettingsUpdateLoading,
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
}
