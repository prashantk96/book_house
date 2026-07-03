import 'package:book_house/features/home/domain/usecases/get_books_usecase.dart';
import 'package:book_house/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetBooksUsecase getBooksUsecase;

  HomeCubit(this.getBooksUsecase) : super(HomeInitial());

  String currentQuery = 'flutter';
  String? currentCategory;
  int? currentMinPrice;
  int? currentMaxPrice;

  Future<void> fetchBooks({
    String query = 'flutter',
    String? category,
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      emit(HomeLoading());

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

      emit(HomeLoaded(books));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> refresh() async {
    await fetchBooks(
      query: currentQuery,
      category: currentCategory,
      minPrice: currentMinPrice,
      maxPrice: currentMaxPrice,
    );
  }

  Future<void> search(String query) async {
    await fetchBooks(
      query: query,
      category: currentCategory,
      minPrice: currentMinPrice,
      maxPrice: currentMaxPrice,
    );
  }

  Future<void> applyFilter({
    String? category,
    int? minPrice,
    int? maxPrice,
  }) async {
    await fetchBooks(
      query: currentQuery,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  Future<void> clearFilters() async {
    currentCategory = null;
    currentMinPrice = null;
    currentMaxPrice = null;

    await fetchBooks(
      query: currentQuery,
    );
  }
}