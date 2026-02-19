import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../main_navigation.dart';

// import '../../../loan/presentation/pages/loan_page.dart';
// import '../../../loan/data/datasources/loan_local_datasource.dart';
// import '../../../loan/data/repositories/loan_repository_impl.dart';
// import '../../../loan/domain/usecases/get_loan.dart';
// import '../../../loan/presentation/cubit/loan_cubit.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'register_page.dart';

int selectedTab = 0; //

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1E8A),
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainNavigation()),
              );
            }
          },

          child: Column(
            children: [
              const SizedBox(height: 40),

              // ----- LOGO -----
              Image.asset('assets/logo_koperasi.png', width: 150, height: 150),
              const SizedBox(height: 24),

              Text(
                'Koperasi Karyawan',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              Text(
                'Indomobil MT Haryono',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 40),

              // ----- LOGIN AREA -----
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //----- GANTI TAB -----
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => selectedTab = 0);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        selectedTab == 0
                                            ? Colors.white
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Masuk',
                                    style: GoogleFonts.beVietnamPro(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() => selectedTab = 1);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Daftar',
                                    style: GoogleFonts.beVietnamPro(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Hi, Selamat Datang!',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Silahkan masukkan data untuk melanjutkan menggunakan aplikasi',
                        style: GoogleFonts.beVietnamPro(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ----- EMAIL -----
                      Text(
                        'Username atau Email',
                        style: GoogleFonts.beVietnamPro(fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Example@gmail.com',
                          prefixIcon: const Icon(Icons.person_outline),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ----- PASSWORT -----
                      Text(
                        'Password',
                        style: GoogleFonts.beVietnamPro(fontSize: 13),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: passwordController,
                        obscureText: obscurePassword,
                        decoration: InputDecoration(
                          hintText: '********',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ----- REMEMBER ME & FORGOT PASSWORD -----
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                'Remember Me',
                                style: GoogleFonts.beVietnamPro(),
                              ),
                            ],
                          ),
                          Text(
                            'Forgot Password',
                            style: GoogleFonts.beVietnamPro(color: Colors.red),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ----- LOGIN BUTTON -----
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0B1E8A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            context.read<AuthCubit>().login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
