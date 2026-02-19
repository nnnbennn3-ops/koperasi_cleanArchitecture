import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_forms.dart';
import 'form_state.dart';

class FormCubit extends Cubit<FormStatus> {
  final GetForms getForms;

  FormCubit(this.getForms) : super(FormInitial());

  void fetchForms() async {
    try {
      emit(FormLoading());
      final data = await getForms();
      emit(FormLoaded(data));
    } catch (e) {
      emit(FormError(e.toString()));
    }
  }
}
