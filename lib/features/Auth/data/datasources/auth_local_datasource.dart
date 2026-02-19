import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class AuthLocalDataSource {
  Future<List<UserModel>> getUsers() async {
    final response = await rootBundle.loadString('assets/data/login.json');

    final data = json.decode(response);

    final List users = data['users'];
    return users.map((e) => UserModel.fromJson(e)).toList();
  }
}
