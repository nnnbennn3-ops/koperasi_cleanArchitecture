import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/loan_model.dart';

class LoanLocalDataSource {
  Future<LoanModel> getLoan() async {
    final response = await rootBundle.loadString('assets/data/loan.json');
    final List data = json.decode(response);
    return LoanModel.fromJson(data.first);
  }
}
