import 'package:book_house/features/home/domain/entities/book_entity.dart';
import 'package:book_house/features/home/domain/repositories/book_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetBooksUsecase {
  final BookRepository repository;

  GetBooksUsecase(this.repository);

  Future<List<BookEntity>> call({
    String query = 'flutter',
    String? category,
    int? minPrice,
    int? maxPrice,
  }) {
    return repository.getBooks(
      query: query,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}
