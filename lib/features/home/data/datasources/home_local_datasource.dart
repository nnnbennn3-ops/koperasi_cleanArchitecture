import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/home_model.dart';
import '../models/transaction_model.dart';

class HomeLocalDataSource {
  Future<HomeModel> getHome({required int page}) async {
    final jsonString = await rootBundle.loadString('assets/data/home.json');

    final List data = json.decode(jsonString);
    final fullModel = HomeModel.fromJson(data.first);

    const pageSize = 10;

    final startIndex = (page - 1) * pageSize;
    final endIndex = startIndex + pageSize;

    final List<TransactionModel> totalTransactions =
        fullModel.transactions.map((e) => e as TransactionModel).toList();

    if (startIndex >= totalTransactions.length) {
      return fullModel.copyWith(transactions: []);
    }

    final pagedTransactions = totalTransactions.sublist(
      startIndex,
      endIndex > totalTransactions.length ? totalTransactions.length : endIndex,
    );

    return fullModel.copyWith(transactions: pagedTransactions);
  }
}
