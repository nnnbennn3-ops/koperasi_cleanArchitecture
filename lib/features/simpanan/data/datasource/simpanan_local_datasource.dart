import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/simpanan_model.dart';

class SimpananLocalDataSource {
  Future<SimpananModel> getSimpanan({required String type}) async {
    final jsonString = await rootBundle.loadString(
      'assets/data/simpanan_$type.json',
    );
    final Map<String, dynamic> data = json.decode(jsonString);
    return SimpananModel.fromJson(data);
  }
}
