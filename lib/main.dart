import 'package:clean_architecture/features/home/data/datasources/home_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/pages/login_page.dart';

import 'features/home/data/repositories/home_repository_impl.dart';
// import 'features/home/data/datasources/home_local_datasource.dart';
import 'features/home/domain/usecases/get_home.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

import 'core/services/secure_storage_service.dart';

void main() {
  // ------ AUTH -----
  final authDataSource = AuthLocalDataSource();
  final secureStorageService = SecureStorageService();
  final authRepository = AuthRepositoryImpl(
    authDataSource,
    secureStorageService,
  );
  final loginUsecase = Login(authRepository);

  // ----- HOME -----
  final homeDataSource = HomeLocalDataSource();
  final homeRepository = HomeRepositoryImpl(homeDataSource);
  final getHomeUsecase = GetHome(homeRepository);

  runApp(MyApp(loginUsecase: loginUsecase, getHomeUsecase: getHomeUsecase));
}

class MyApp extends StatelessWidget {
  final Login loginUsecase;
  final GetHome getHomeUsecase;

  const MyApp({
    super.key,
    required this.loginUsecase,
    required this.getHomeUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit(loginUsecase)),
        BlocProvider(create: (_) => HomeCubit(getHomeUsecase)),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
