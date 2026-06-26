import 'dart:convert';
import 'package:flutter/services.dart';

class SettingsLocalDataSource {
  Future<Map<String, dynamic>> getProfile() async {
    final jsonString = await rootBundle.loadString('assets/data/profile.json');
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  Future<void> updateBank({
    required String bank,
    required String account,
    required String name,
  }) async {
    //Nanti ganti dari API
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    //Validasi seadanya dulu - nanti dari API
    await Future.delayed(const Duration(milliseconds: 300));
    if (oldPassword.isEmpty || newPassword.isEmpty) {
      throw Exception('Password tidak boleh kosong');
    }
    if (newPassword.length < 6) {
      throw Exception('Password baru minimal 6 karakter');
    }
  }
}
