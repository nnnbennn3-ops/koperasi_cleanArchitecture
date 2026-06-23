import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_home.dart';
import 'home_state.dart';
import 'package:flutter/widgets.dart';

class MonthGroup {
  final String label;
  final String key;
  final double deposit;
  final double withdraw;
  final List<TransactionEntity> transactions;

  const MonthGroup({
    required this.label,
    required this.key,
    required this.deposit,
    required this.withdraw,
    required this.transactions,
  });
}

class HomeCubit extends Cubit<HomeState> {
  final GetHome getHome;

  static const pageSize = 10;

  // Track GlobalKey dan summary per bulan
  final Map<String, GlobalKey> _monthKeys = {};
  final Map<String, MonthGroup> _monthGroups = {};
  String currentMonth = '';

  HomeCubit(this.getHome) : super(HomeInitial()) {
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    try {
      emit(HomeLoading());
      final home = await getHome(page: 1);
      emit(HomeLoaded(home));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<List<TransactionEntity>> fetchPage(int pageKey) async {
    final home = await getHome(page: pageKey);
    return home.transactions;
  }

  void registerMonthKey(String monthKey, GlobalKey key, MonthGroup group) {
    _monthKeys[monthKey] = key;
    _monthGroups[monthKey] = group;
  }

  void evaluatePinnedMonth(double scrollOffset, {double headerHeight = 100}) {
    String? candidateMonth;
    double bestDy = double.negativeInfinity;

    for (final entry in _monthKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;

      final dy = box.localToGlobal(Offset.zero).dy;

      // Threshold = tinggi fixed header + tinggi sticky header (52)
      final threshold = headerHeight + 52;

      if (dy <= threshold && dy > bestDy) {
        bestDy = dy;
        candidateMonth = entry.key;
      }
    }

    if (candidateMonth == null) {
      _updateCurrentMonth('');
      return;
    }

    _updateCurrentMonth(candidateMonth);
  }

  void _updateCurrentMonth(String month) {
    if (currentMonth == month) return;
    currentMonth = month;
    final group = _monthGroups[month];
    emit(HomeMonthChanged(month, group));
  }

  static List<MonthGroup> groupByMonth(List<TransactionEntity> transactions) {
    final Map<String, List<TransactionEntity>> grouped = {};

    for (final trx in transactions) {
      final key = '${_monthName(trx.date.month)} ${trx.date.year}';
      grouped.putIfAbsent(key, () => []).add(trx);
    }

    final sortedKeys =
        grouped.keys.toList()..sort((a, b) {
          final aDate = grouped[a]!.first.date;
          final bDate = grouped[b]!.first.date;
          return bDate.compareTo(aDate); // newest first
        });

    return sortedKeys.map((key) {
      final items = grouped[key]!;
      final deposit = items
          .where((t) => t.type == 'deposit')
          .fold(0.0, (sum, t) => sum + t.amount);
      final withdraw = items
          .where((t) => t.type == 'withdraw')
          .fold(0.0, (sum, t) => sum + t.amount);

      return MonthGroup(
        key: key,
        label: key,
        deposit: deposit,
        withdraw: withdraw,
        transactions: items,
      );
    }).toList();
  }

  static const _months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static String _monthName(int month) => _months[month];

  void reset() {
    _monthKeys.clear();
    _monthGroups.clear();
    currentMonth = '';
    fetchInitial();
  }
}
