import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_loan.dart';
import 'loan_state.dart';

class LoanCubit extends Cubit<LoanState> {
  final GetLoan getLoan;

  LoanCubit(this.getLoan) : super(LoanInitial());

  void fetchLoan() async {
    try {
      emit(LoanLoading());
      final loan = await getLoan();
      emit(LoanLoaded(loan));
    } catch (e) {
      emit(LoanError(e.toString()));
    }
  }
}
