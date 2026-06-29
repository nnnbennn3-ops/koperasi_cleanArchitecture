import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_simpanan_usecase.dart';
import 'simpanan_state.dart';

class SimpananCubit extends Cubit<SimpananState> {
  final SimpananUsecase usecase;

  SimpananCubit(this.usecase) : super(SimpananInitial());

  Future<void> fetch({required String type}) async {
    try {
      emit(SimpananLoading());
      final simpanan = await usecase.getSimpanan(type: type);
      emit(SimpananLoaded(simpanan));
    } catch (e) {
      emit(SimpananError(e.toString()));
    }
  }
}
