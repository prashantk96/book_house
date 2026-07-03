import 'package:book_house/core/constants/api_constants.dart';
import 'package:book_house/features/home/domain/entities/book_entity.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class BookRemoteDatasource {
  final Dio dio;

  BookRemoteDatasource(this.dio);

  Future<List<BookEntity>> getBooks({
    String query = 'flutter',
    String? category,
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      String searchQuery = query.trim();

      if (category != null && category.isNotEmpty) {
        searchQuery += '+subject:$category';
      }

      final response = await dio.get(
        ApiConstants.googleBooksSearch,
        queryParameters: {
          'q': searchQuery,
          'maxResults': 20,
          'printType': 'books',
          'projection': 'lite',
          'key': ApiConstants.googleBooksApiKey,
        },
      );

      final List items = response.data['items'] ?? [];

      final books = items.map<BookEntity>((item) {
        final info = item['volumeInfo'] ?? {};
        final saleInfo = item['saleInfo'] ?? {};

        return BookEntity(
          id: item['id']?.toString() ?? '',

          title: info['title']?.toString() ?? 'Unknown Title',

          author: _parseAuthors(info['authors']),

          description: info['description']?.toString() ?? '',

          thumbnail: _parseThumbnail(info['imageLinks']),

          rating: _parseRating(info['averageRating']),

          pageCount: info['pageCount'] is int ? info['pageCount'] : 0,

          publishedDate: info['publishedDate']?.toString() ?? '',

          publisher: info['publisher']?.toString() ?? '',

          previewLink: info['previewLink']?.toString() ?? '',

          price: _parsePrice(saleInfo),
        );
      }).toList();

      return books.where((book) {
        final price = book.price ?? 0;

        if (minPrice != null && price < minPrice) {
          return false;
        }

        if (maxPrice != null && price > maxPrice) {
          return false;
        }

        return true;
      }).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data.toString() ?? e.message ?? 'Network Error',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String _parseAuthors(dynamic authors) {
    if (authors == null) {
      return 'Unknown Author';
    }

    if (authors is List && authors.isNotEmpty) {
      return authors.join(', ');
    }

    return 'Unknown Author';
  }

  String _parseThumbnail(dynamic imageLinks) {
    if (imageLinks == null) {
      return '';
    }

    return imageLinks['thumbnail'] ?? imageLinks['smallThumbnail'] ?? '';
  }

  double _parseRating(dynamic rating) {
    if (rating == null) {
      return 0;
    }

    if (rating is int) {
      return rating.toDouble();
    }

    if (rating is double) {
      return rating;
    }

    return 0;
  }

  double? _parsePrice(dynamic saleInfo) {
    try {
      if (saleInfo == null) {
        return null;
      }

      final retailPrice = saleInfo['retailPrice'];

      if (retailPrice == null) {
        return null;
      }

      final amount = retailPrice['amount'];

      if (amount is int) {
        return amount.toDouble();
      }

      if (amount is double) {
        return amount;
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
