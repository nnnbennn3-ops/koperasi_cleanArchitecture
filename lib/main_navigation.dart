import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/injection_container.dart';

import 'package:clean_architecture/features/home/presentation/cubit/home_cubit.dart';
import 'package:clean_architecture/features/home/presentation/pages/home_page.dart';

import 'package:clean_architecture/features/portofolio/presentation/cubit/portofolio_cubit.dart';
import 'package:clean_architecture/features/portofolio/presentation/cubit/portofolio_state.dart';
import 'package:clean_architecture/features/portofolio/presentation/pages/portofolio_page.dart';

import 'package:clean_architecture/features/form/presentation/cubit/form_cubit.dart';
import 'package:clean_architecture/features/form/presentation/pages/form_page.dart';

import 'package:clean_architecture/features/Settings/presentation/cubit/settings_cubit.dart';
import 'package:clean_architecture/features/Settings/presentation/pages/settings_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  static const _kNavy = Color(0xFF0D1461);

  static const _navItems = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Beranda',
    ),
    _NavItem(
      icon: Icons.pie_chart_outline,
      activeIcon: Icons.pie_chart,
      label: 'Portofolio',
    ),
    _NavItem(
      icon: Icons.description_outlined,
      activeIcon: Icons.description,
      label: 'Formulir',
    ),
    _NavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Pengaturan',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          // Tiap tab wrapped _KeepAlivePage supaya cubit tidak recreate
          // saat ganti tab, tapi tetap fresh saat MainNavigation recreate
          // (setelah logout → login)
          _KeepAlivePage(child: _HomeTab()),
          _KeepAlivePage(child: _PortofolioTab()),
          _KeepAlivePage(child: _FormTab()),
          _KeepAlivePage(child: _SettingsTab()),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isActive = _currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _currentIndex = index),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isActive
                                    ? _kNavy.withOpacity(0.12)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            isActive ? item.activeIcon : item.icon,
                            color: isActive ? _kNavy : Colors.grey.shade500,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                isActive ? FontWeight.w600 : FontWeight.w400,
                            color: isActive ? _kNavy : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// Supaya state tiap tab tidak di-dispose saat ganti tab
class _KeepAlivePage extends StatefulWidget {
  final Widget child;
  const _KeepAlivePage({required this.child});

  @override
  State<_KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}

// Tiap tab punya BlocProvider sendiri — fresh saat MainNavigation recreate

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..fetchInitial(),
      child: const HomePage(),
    );
  }
}

class _PortofolioTab extends StatelessWidget {
  const _PortofolioTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PortofolioCubit>()..fetch(),
      child: BlocBuilder<PortofolioCubit, PortofolioState>(
        builder: (context, state) {
          if (state is PortofolioLoading || state is PortofolioInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PortofolioLoaded) {
            return PortfolioPage(
              items: state.portofolio.items,
              totalSaldo: state.portofolio.totalSaldo,
            );
          }
          if (state is PortofolioError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _FormTab extends StatelessWidget {
  const _FormTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FormCubit>()..fetchForms(),
      child: const FormPage(),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>()..fetchProfile(),
      child: const SettingsPage(),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
