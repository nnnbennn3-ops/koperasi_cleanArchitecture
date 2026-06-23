import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String memberNo;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.memberNo,
  });

  @override
  List<Object?> get props => [id, email, name, memberNo];
}
