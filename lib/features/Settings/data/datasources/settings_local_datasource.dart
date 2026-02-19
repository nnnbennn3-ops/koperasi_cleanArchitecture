class SettingsLocalDataSource {
  Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      "name": "Joe Mama",
      "memberId": "167168",
      "bankName": "BCA",
      "accountNumber": "667788345",
    };
  }

  Future<void> updateBank() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> changePassword() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
