import 'package:equatable/equatable.dart';
import '../../domain/entities/portofolio.dart';

abstract class PortofolioState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PortofolioInitial extends PortofolioState {}

class PortofolioLoading extends PortofolioState {}

class PortofolioLoaded extends PortofolioState {
  final PortofolioEntity portofolio;
  PortofolioLoaded(this.portofolio);

  @override
  List<Object?> get props => [portofolio];
}

class PortofolioError extends PortofolioState {
  final String message;
  PortofolioError(this.message);

  @override
  List<Object?> get props => [message];
}
