import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get googleBooksBaseUrl =>
      dotenv.env['GOOGLE_BOOKS_BASE_URL'] ?? '';

  static String get openLibraryBaseUrl =>
      dotenv.env['OPEN_LIBRARY_BASE_URL'] ?? '';

  static String get googleBooksApiKey =>
      dotenv.env['GOOGLE_BOOKS_API_KEY'] ?? '';

  static String get googleBooksSearch => '$googleBooksBaseUrl/volumes';

  static String googleBookDetails(String id) =>
      '$googleBooksBaseUrl/volumes/$id';

  static Map<String, dynamic> googleBooksQuery({
    required String query,
    int maxResults = 20,
    int startIndex = 0,
  }) {
    return {
      'q': query,
      'maxResults': maxResults,
      'startIndex': startIndex,
      'key': googleBooksApiKey,
    };
  }

  static String get openLibrarySearch => '$openLibraryBaseUrl/search.json';

  static String openLibraryBook(String olid) =>
      '$openLibraryBaseUrl/books/$olid.json';

  static String openLibraryWorks(String workId) =>
      '$openLibraryBaseUrl/works/$workId.json';

  static String openLibraryAuthor(String authorId) =>
      '$openLibraryBaseUrl/authors/$authorId.json';

  static String coverImage({
    required int coverId,
    String size = 'M', // S, M, L
  }) => 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';
}
