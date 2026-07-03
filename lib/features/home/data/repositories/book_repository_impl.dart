import 'package:book_house/features/home/data/datasource/book_remote_datasource.dart';
import 'package:book_house/features/home/domain/entities/book_entity.dart';
import 'package:book_house/features/home/domain/repositories/book_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BookRepository)
class BookRepositoryImpl implements BookRepository {
  final BookRemoteDatasource remote;

  BookRepositoryImpl(this.remote);

  @override
  Future<List<BookEntity>> getBooks({
    String query = 'flutter',
    String? category,
    int? minPrice,
    int? maxPrice,
  }) {
    return remote.getBooks(
      query: query,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}
