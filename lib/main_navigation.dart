import 'package:clean_architecture/features/Settings/data/datasources/settings_local_datasource.dart';
import 'package:clean_architecture/features/Settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import 'features/portofolio/presentation/pages/portofolio_page.dart';
import 'package:clean_architecture/features/portofolio/presentation/cubit/portofolio_cubit.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:clean_architecture/features/form/data/datasources/form_local_datasource.dart';
import 'package:clean_architecture/features/form/data/repositories/form_repository_impl.dart';
import 'package:clean_architecture/features/form/domain/usecases/get_forms.dart';
import 'package:clean_architecture/features/form/presentation/cubit/form_cubit.dart';
import 'package:clean_architecture/features/form/presentation/pages/form_page.dart';

import 'package:clean_architecture/features/Settings/domain/usecases/get_profile.dart';
import 'package:clean_architecture/features/Settings/presentation/cubit/settings_cubit.dart';
import 'package:clean_architecture/features/Settings/presentation/pages/settings_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    BlocProvider(
      create: (_) => sl<PortofolioCubit>()..fetch(),
      child: BlocBuilder<PortofolioCubit, PortofolioState>(
        builder: (context, state) {
          if (state is PortofolioLoading || state is PortofolioInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PortofolioLoaded) {
            return PortfolioPage(items: state.items, totalSaldo: state.total);
          }
          if (state is PortofolioError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    ),
    BlocProvider(
      create: (_) {
        final dataSource = FormLocalDataSource();
        final repo = FormRepositoryImpl(dataSource);
        final usecase = GetForms(repo);
        return FormCubit(usecase)..fetchForms();
      },
      child: const FormPage(),
    ),
    BlocProvider(
      create: (_) {
        final dataSource = SettingsLocalDataSource();
        final repo = SettingsRepositoryImpl(dataSource);
        final usecase = GetProfile(repo);
        return SettingsCubit(usecase)..fetchProfile();
      },
      child: const SettingsPage(),
    ),
  ];

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
      body: IndexedStack(index: _currentIndex, children: _pages),
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
                        // Pill background hanya untuk item aktif
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
