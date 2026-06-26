import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.name,
    required super.memberId,
    required super.bankName,
    required super.accountNumber,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'] as String,
      memberId: json['member_id'] as String,
      bankName: json['bank_name'] as String,
      accountNumber: json['account_number'] as String,
    );
  }
}
