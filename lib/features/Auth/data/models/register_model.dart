import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String memberNo;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const RegisterModel({
    required this.memberNo,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [
    memberNo,
    email,
    phone,
    password,
    confirmPassword,
  ];
}
