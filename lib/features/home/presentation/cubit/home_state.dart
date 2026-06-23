import '../../domain/entities/home.dart';
import 'package:equatable/equatable.dart';
import 'home_cubit.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeEntity home;
  HomeLoaded(this.home);

  @override
  List<Object?> get props => [home];
}

class HomeMonthChanged extends HomeState {
  final String month;
  final MonthGroup? group;
  HomeMonthChanged(this.month, this.group);

  @override
  List<Object?> get props => [month, group];
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
