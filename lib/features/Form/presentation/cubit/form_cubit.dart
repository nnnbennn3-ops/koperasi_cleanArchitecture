import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_form_usecase.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormulirState> {
  final FormUsecase usecase;

  FormCubit(this.usecase) : super(FormulirInitial());

  Future<void> fetchForms() async {
    try {
      emit(FormulirLoading());
      final forms = await usecase.getForms();
      emit(FormulirLoaded(forms));
    } catch (e) {
      emit(FormulirError(e.toString()));
    }
  }
}
