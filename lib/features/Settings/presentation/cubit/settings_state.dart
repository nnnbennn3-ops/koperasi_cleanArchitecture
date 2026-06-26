import 'package:equatable/equatable.dart';
import '../../domain/entities/user_profile.dart';

abstract class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserProfile profile;
  SettingsLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class SettingsUpdateLoading extends SettingsState {}

class SettingsUpdateSuccess extends SettingsState {
  final String message;
  SettingsUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SettingsError extends SettingsState {
  final String message;
  SettingsError(this.message);

  @override
  List<Object?> get props => [message];
}
