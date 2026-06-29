import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_loan_usecase.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  final LoanUsecase usecase;

  LoanCubit(this.usecase) : super(LoanInitial());

  Future<void> fetchLoan() async {
    try {
      emit(LoanLoading());
      final loan = await usecase.getLoan();
      emit(LoanLoaded(loan));
    } catch (e) {
      emit(LoanError(e.toString()));
    }
  }
}
