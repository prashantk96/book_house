import 'package:book_house/features/home/domain/entities/book_entity.dart';

abstract class BookRepository {
  Future<List<BookEntity>> getBooks({
    String query,
    String? category,
    int? minPrice,
    int? maxPrice,
  });
}
