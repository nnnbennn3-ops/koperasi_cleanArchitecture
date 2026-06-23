import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/home_model.dart';

class HomeLocalDataSource {
  Future<HomeModel> getHome({required int page}) async {
    final jsonString = await rootBundle.loadString('assets/data/home.json');
    final List data = json.decode(jsonString);

    return HomeModel.fromJson(data.first);
  }
}
