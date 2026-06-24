import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/portofolio_model.dart';

class PortofolioLocalDataSource {
  Future<PortofolioModel> getPortofolio() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/portofolio.json',
    );
    return PortofolioModel.fromJson(json.decode(jsonString));
  }
}
