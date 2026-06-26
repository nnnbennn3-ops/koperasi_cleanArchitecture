import 'package:equatable/equatable.dart';
import '../../domain/entities/simpanan.dart';

abstract class SimpananState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SimpananInitial extends SimpananState {}

class SimpananLoading extends SimpananState {}

class SimpananLoaded extends SimpananState {
  final SimpananEntity simpanan;
  SimpananLoaded(this.simpanan);

  @override
  List<Object?> get props => [simpanan];
}

class SimpananError extends SimpananState {
  final String message;
  SimpananError(this.message);

  @override
  List<Object?> get props => [message];
}
