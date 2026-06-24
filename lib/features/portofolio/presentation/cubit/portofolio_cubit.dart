import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_portofolio.dart';
import 'portofolio_state.dart';

class PortofolioCubit extends Cubit<PortofolioState> {
  final GetPortofolio getPortofolio;

  PortofolioCubit(this.getPortofolio) : super(PortofolioInitial());

  Future<void> fetch() async {
    try {
      emit(PortofolioLoading());
      final portofolio = await getPortofolio();
      emit(PortofolioLoaded(portofolio));
    } catch (e) {
      emit(PortofolioError(e.toString()));
    }
  }
}
