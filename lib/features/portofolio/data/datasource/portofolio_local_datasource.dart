import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PortofolioLocalDataSource {
  Future<Map<String, dynamic>> getPortofolio() async {
    final jsonString = await rootBundle.loadString(
      'assets/data/portofolio.json',
    );
    return json.decode(jsonString) as Map<String, dynamic>;
  }
}
