import 'dart:convert';
import 'package:flutter/services.dart';

class AuthLocalDataSource {
  // Simulate registered users yang tersimpan di memory selama session
  // Nanti diganti dengan API call
  final List<Map<String, dynamic>> _registeredUsers = [];

  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final response = await rootBundle.loadString('assets/data/login.json');
    final data = json.decode(response);
    final List users = data['users'];

    try {
      // Support login pakai email ATAU nomor anggota
      final user = users.firstWhere(
        (u) =>
            (u['email'] == identifier || u['member_no'] == identifier) &&
            u['password'] == password,
      );
      return Map<String, dynamic>.from(user);
    } catch (_) {
      throw Exception('Email/nomor anggota atau password salah');
    }
  }

  Future<Map<String, dynamic>> register({
    required String memberNo,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Cek duplikat email atau member_no
    final isDuplicate = _registeredUsers.any(
      (u) => u['email'] == email || u['member_no'] == memberNo,
    );
    if (isDuplicate) {
      throw Exception('Email atau nomor anggota sudah terdaftar');
    }

    final newUser = {
      'id': DateTime.now().millisecondsSinceEpoch,
      'email': email,
      'member_no': memberNo,
      'phone': phone,
      'name': email.split('@').first, // placeholder, nanti dari API
    };

    _registeredUsers.add({...newUser, 'password': password});
    return newUser;
  }
}
