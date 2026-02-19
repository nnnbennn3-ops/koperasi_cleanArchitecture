import 'package:clean_architecture/features/Settings/data/datasources/settings_local_datasource.dart';
import 'package:clean_architecture/features/Settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter/material.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/portofolio_page.dart';
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
    const PortfolioPage(),

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Portofolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Formulir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
