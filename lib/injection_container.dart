import 'package:get_it/get_it.dart';

import 'features/home/injection.home.dart';
import 'features/form/injection_form.dart';
import 'features/loan/injection_loan.dart';
import 'features/Auth/injection_auth.dart';
import 'features/portofolio/injection_portofolio.dart';
import 'features/simpanan/injection_simpanan.dart';
import 'features/Settings/injection_settings.dart';

final sl = GetIt.instance;

Future<void> init() async {
  initHomeInjection();
  initFormInjection();
  initLoanInjection();
  initAuthInjection();
  initPortofolioInjection();
  initSimpananInjection();
  initSettingsInjection();
}
