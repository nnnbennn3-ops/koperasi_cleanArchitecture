import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../main_navigation.dart';
import 'package:clean_architecture/core/widgets/app_input_widgets.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'package:clean_architecture/features/Auth/data/models/register_model.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1E8A),
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is AuthSuccess || state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavigation()),
            );
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              // ---- HEADER ----
              _buildHeader(),

              // ---- BOTTOM SHEET AREA ----
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // ---- TAB TOGGLE ----
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: _buildTabToggle(),
                      ),
                      const SizedBox(height: 4),
                      // ---- TAB CONTENT ----
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [_LoginTab(), _RegisterTab()],
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/logo_koperasi.png',
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Koperasi Karyawan',
            style: GoogleFonts.beVietnamPro(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Indomobil MT Haryono',
            style: GoogleFonts.beVietnamPro(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabToggle() {
    final isLogin = _tabController.index == 0;
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _tabItem('Masuk', 0, isLogin),
          _tabItem('Daftar', 1, !isLogin),
        ],
      ),
    );
  }

  Widget _tabItem(String label, int index, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _tabController.animateTo(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive ? Colors.black87 : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// LOGIN TAB
// ============================================================
class _LoginTab extends StatefulWidget {
  const _LoginTab();

  @override
  State<_LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<_LoginTab> {
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadRemembered();
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadRemembered() async {
    final cubit = context.read<AuthCubit>();
    final identifier = await cubit.getRememberedIdentifier();
    final password = await cubit.getRememberedPassword();
    if (identifier != null && mounted) {
      _identifierController.text = identifier;
      if (password != null) _passwordController.text = password;
      setState(() => _rememberMe = true);
    }
  }

  Future<void> _onLogin() async {
    final cubit = context.read<AuthCubit>();
    if (_rememberMe) {
      await cubit.saveRememberMe(
        _identifierController.text.trim(),
        _passwordController.text,
      );
    } else {
      await cubit.clearRememberedCredentials();
    }
    cubit.login(_identifierController.text.trim(), _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, Selamat Datang!',
            style: GoogleFonts.beVietnamPro(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Silakan masukkan data untuk melanjutkan penggunaan aplikasi.',
            style: GoogleFonts.beVietnamPro(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),

          // ---- IDENTIFIER ----
          appLabel('Nomor Anggota atau Email'),
          const SizedBox(height: 6),
          appTextField(
            controller: _identifierController,
            hint: 'Example@gmail.com',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          // ---- PASSWORD ----
          appLabel('Password'),
          const SizedBox(height: 6),
          appPasswordField(
            label: '',
            controller: _passwordController,
            obscure: _obscurePassword,
            onToggle:
                () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 8),

          // ---- REMEMBER ME + FORGOT PASSWORD ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    activeColor: const Color(0xFF0B1E8A),
                    onChanged: (v) => setState(() => _rememberMe = v ?? false),
                  ),
                  Text(
                    'Remember Me',
                    style: GoogleFonts.beVietnamPro(fontSize: 13),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // TODO: forgot password
                },
                child: Text(
                  'Forgot Password',
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 13,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ---- LOGIN BUTTON ----
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return appPrimaryButton(
                label: 'Login',
                onPressed: _onLogin,
                isLoading: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// REGISTER TAB
// ============================================================
class _RegisterTab extends StatefulWidget {
  const _RegisterTab();

  @override
  State<_RegisterTab> createState() => _RegisterTabState();
}

class _RegisterTabState extends State<_RegisterTab> {
  final _memberController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _memberController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onRegister() {
    context.read<AuthCubit>().register(
      RegisterModel(
        memberNo: _memberController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        password: _passwordController.text,
        confirmPassword: _confirmController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daftar Sekarang',
            style: GoogleFonts.beVietnamPro(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),

          // ---- FIELDS ----
          appLabel('Nomor Anggota'),
          const SizedBox(height: 6),
          appTextField(
            controller: _memberController,
            hint: 'Masukkan nomor anggota',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          appLabel('Email'),
          const SizedBox(height: 6),
          appTextField(
            controller: _emailController,
            hint: 'Input Email',
            icon: Icons.mail_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          appLabel('Nomor Ponsel'),
          const SizedBox(height: 6),
          appTextField(
            controller: _phoneController,
            hint: '+62 xxxxxxxxxx',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          appPasswordField(
            label: 'Password',
            controller: _passwordController,
            obscure: _obscurePassword,
            onToggle:
                () => setState(() => _obscurePassword = !_obscurePassword),
          ),
          const SizedBox(height: 16),

          appPasswordField(
            label: 'Confirm Password',
            controller: _confirmController,
            obscure: _obscureConfirm,
            onToggle: () => setState(() => _obscureConfirm = !_obscureConfirm),
          ),
          const SizedBox(height: 28),

          // ---- REGISTER BUTTON ----
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;
              return appPrimaryButton(
                label: 'Register',
                onPressed: _onRegister,
                isLoading: isLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}
