import '../../domain/entities/simpanan.dart';

abstract class SimpananState {}

class SimpananInitial extends SimpananState {}

class SimpananLoading extends SimpananState {}

class SimpananLoaded extends SimpananState {
  final SimpananEntity simpanan;
  SimpananLoaded(this.simpanan);
}

class SimpananError extends SimpananState {
  final String message;
  SimpananError(this.message);
}
