import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_simpanan.dart';
import 'simpanan_state.dart';

class SimpananCubit extends Cubit<SimpananState> {
  final GetSimpanan getSimpanan;

  SimpananCubit(this.getSimpanan) : super(SimpananInitial());

  Future<void> fetch({required String type}) async {
    try {
      emit(SimpananLoading());
      final simpanan = await getSimpanan(type: type);
      emit(SimpananLoaded(simpanan));
    } catch (e) {
      emit(SimpananError(e.toString()));
    }
  }
}
