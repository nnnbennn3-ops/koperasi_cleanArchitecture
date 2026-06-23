import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/portofolio_model.dart';
import '../../domain/usecases/get_portofolio.dart';

abstract class PortofolioState {}

class PortofolioInitial extends PortofolioState {}

class PortofolioLoading extends PortofolioState {}

class PortofolioLoaded extends PortofolioState {
  final List<PortofolioItem> items;
  final double total;
  PortofolioLoaded({required this.items, required this.total});
}

class PortofolioError extends PortofolioState {
  final String message;
  PortofolioError(this.message);
}

class PortofolioCubit extends Cubit<PortofolioState> {
  final GetPortofolio getPortofolio;

  PortofolioCubit(this.getPortofolio) : super(PortofolioInitial());

  Future<void> fetch() async {
    try {
      emit(PortofolioLoading());
      final data = await getPortofolio();
      final items =
          (data['items'] as List)
              .map((e) => PortofolioItem.fromJson(e as Map<String, dynamic>))
              .toList();
      final total =
          (data['total_saldo'] is int)
              ? (data['total_saldo'] as int).toDouble()
              : (data['total_saldo'] as double?) ?? 0.0;
      emit(PortofolioLoaded(items: items, total: total));
    } catch (e) {
      emit(PortofolioError(e.toString()));
    }
  }
}
