import 'package:clean_architecture/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clean_architecture/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'change_password_page.dart';
import 'rekening_bank_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F5F7),
      appBar: AppBar(
        title: Text("Personal Information", style: GoogleFonts.beVietnamPro()),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingsLoaded) {
            final profile = state.profile;

            return Column(
              children: [
                const SizedBox(height: 20),

                // ----- PROFIL -----
                ListTile(
                  leading: const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage("assets/profil.jpg"),
                  ),
                  title: Text(
                    profile.name,
                    style: GoogleFonts.beVietnamPro(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    profile.memberId,
                    style: GoogleFonts.beVietnamPro(),
                  ),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.account_balance),
                  title: Text(
                    "Rekening Bank",
                    style: GoogleFonts.beVietnamPro(),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RekeningBankPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: Text(
                    "Ganti Password",
                    style: GoogleFonts.beVietnamPro(),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                const Divider(),

                ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text("Logout", style: GoogleFonts.beVietnamPro()),
                  onTap: () async {
                    await context.read<AuthCubit>().logout();
                    if (!context.mounted) return;
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginPage()),
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
}
