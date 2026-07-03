import 'package:book_house/features/home/domain/usecases/get_books_usecase.dart';
import 'package:book_house/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetBooksUsecase getBooksUsecase;

  HomeCubit(this.getBooksUsecase) : super(HomeInitial());

  bool isListView = true;
  int selectedTab = 0;

  String currentQuery = 'flutter';
  String? currentCategory;
  int? currentMinPrice;
  int? currentMaxPrice;

  void changeView(bool value) {
    isListView = value;

    if (state is HomeLoaded) {
      emit(
        HomeLoaded(
          (state as HomeLoaded).books,
          isListView: isListView,
          selectedTab: selectedTab,
        ),
      );
    }
  }

  void changeTab(int index) {
    selectedTab = index;

    if (state is HomeLoaded) {
      emit(
        HomeLoaded(
          (state as HomeLoaded).books,
          isListView: isListView,
          selectedTab: selectedTab,
        ),
      );
    }
  }

  Future<void> search(String query) async {
    await fetchBooks(
      query: query,
      category: currentCategory,
      minPrice: currentMinPrice,
      maxPrice: currentMaxPrice,
    );
  }

  Future<void> fetchBooks({
    String query = 'flutter',
    String? category,
    int? minPrice,
    int? maxPrice,
  }) async {
    emit(HomeLoading(isListView: isListView, selectedTab: selectedTab));

    try {
      currentQuery = query;
      currentCategory = category;
      currentMinPrice = minPrice;
      currentMaxPrice = maxPrice;

      final books = await getBooksUsecase(
        query: query,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      emit(HomeLoaded(books, isListView: isListView, selectedTab: selectedTab));
    } catch (e) {
      emit(
        HomeError(
          e.toString(),
          isListView: isListView,
          selectedTab: selectedTab,
        ),
      );
    }
  }
}
