import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/form_model.dart';

class FormLocalDataSource {
  Future<List<FormItemModel>> getForms() async {
    final jsonString = await rootBundle.loadString('assets/data/forms.json');
    final List data = json.decode(jsonString);
    return data
        .map((e) => FormItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
