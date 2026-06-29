import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String memberId;
  final String bankName;
  final String accountNumber;

  const UserProfile({
    required this.name,
    required this.memberId,
    required this.bankName,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [name, memberId, bankName, accountNumber];
}
