import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_home.dart';
import 'home_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHome getHome;

  static const _pageSize = 10;

  final PagingController<int, TransactionEntity> pagingController =
      PagingController(firstPageKey: 1);

  HomeCubit(this.getHome) : super(HomeInitial()) {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _initHome();
  }

  Future<void> _initHome() async {
    try {
      emit(HomeLoading());

      final home = await getHome(page: 1);

      emit(HomeLoaded(home));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final home = await getHome(page: pageKey);

      final isLastPage = home.transactions.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(home.transactions);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(home.transactions, nextPageKey);
      }

      emit(HomeLoaded(home));
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
