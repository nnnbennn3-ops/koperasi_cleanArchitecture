import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portofolio_usecase.dart';
import 'portofolio_state.dart';

class PortofolioCubit extends Cubit<PortofolioState> {
  final PortofolioUsecase usecase;

  PortofolioCubit(this.usecase) : super(PortofolioInitial());

  Future<void> fetch() async {
    try {
      emit(PortofolioLoading());
      final portofolio = await usecase.getPortofolio();
      emit(PortofolioLoaded(portofolio));
    } catch (e) {
      emit(PortofolioError(e.toString()));
    }
  }
}
