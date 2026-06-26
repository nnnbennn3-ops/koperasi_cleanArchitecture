import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_forms.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormulirState> {
  final GetForms getForms;

  FormCubit(this.getForms) : super(FormulirInitial());

  Future<void> fetchForms() async {
    try {
      emit(FormulirLoading());
      final forms = await getForms();
      emit(FormulirLoaded(forms));
    } catch (e) {
      emit(FormulirError(e.toString()));
    }
  }
}
