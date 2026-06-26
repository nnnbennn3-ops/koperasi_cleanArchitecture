import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_it/get_it.dart';

import 'package:clean_architecture/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_architecture/features/Auth/presentation/pages/auth_page.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'change_password_page.dart';
import 'rekening_bank_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance<SettingsCubit>()..fetchProfile(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        title: Text(
          'Personal Information',
          style: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SettingsError) {
            return Center(
              child: Text(
                state.message,
                style: GoogleFonts.beVietnamPro(color: Colors.red),
              ),
            );
          }

          if (state is SettingsLoaded) {
            final profile = state.profile;

            return Column(
              children: [
                const SizedBox(height: 20),

                // ---------------------- Profil --------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage('assets/profil.jpg'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: const BoxDecoration(
                                color: Color(0xFF0B1E8A),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile.name,
                            style: GoogleFonts.beVietnamPro(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            profile.memberId,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                const Divider(height: 1),

                // ----------------- Menu Items ------------------------------
                _menuItem(
                  context,
                  icon: Icons.account_balance,
                  label: 'Rekening Bank',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => RekeningBankPage(
                                bankName: profile.bankName,
                                accountNumber: profile.accountNumber,
                                accountName: profile.name,
                              ),
                        ),
                      ),
                ),
                _menuItem(
                  context,
                  icon: Icons.lock_outline,
                  label: 'Ganti password',
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => BlocProvider.value(
                                value: context.read<SettingsCubit>(),
                                child: const ChangePasswordPage(),
                              ),
                        ),
                      ),
                ),

                const Divider(height: 1),

                _menuItem(
                  context,
                  icon: Icons.logout,
                  label: 'Logout',
                  showTrailing: false,
                  onTap: () async {
                    await context.read<AuthCubit>().logout();
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthPage()),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool showTrailing = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54, size: 22),
      title: Text(label, style: GoogleFonts.beVietnamPro(fontSize: 14)),
      trailing:
          showTrailing
              ? const Icon(Icons.chevron_right, color: Colors.black38)
              : null,
      onTap: onTap,
    );
  }
}
