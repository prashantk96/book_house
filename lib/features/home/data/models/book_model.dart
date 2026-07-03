import 'package:book_house/features/home/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.description,
    required super.thumbnail,
    required super.rating,
    required super.pageCount,
    required super.publishedDate,
    required super.publisher,
    required super.previewLink,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'] ?? {};
    final imageLinks = volumeInfo['imageLinks'] ?? {};

    return BookModel(
      id: json['id'] ?? '',

      title: volumeInfo['title'] ?? 'Unknown Title',

      author: (volumeInfo['authors'] as List?)?.join(', ') ?? 'Unknown Author',

      description: volumeInfo['description'] ?? '',

      thumbnail: imageLinks['thumbnail'] ?? imageLinks['smallThumbnail'] ?? '',

      rating: (volumeInfo['averageRating'] as num?)?.toDouble() ?? 0.0,

      pageCount: volumeInfo['pageCount'] ?? 0,

      publishedDate: volumeInfo['publishedDate'] ?? '',

      publisher: volumeInfo['publisher'] ?? '',

      previewLink: volumeInfo['previewLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'thumbnail': thumbnail,
      'rating': rating,
      'pageCount': pageCount,
      'publishedDate': publishedDate,
      'publisher': publisher,
      'previewLink': previewLink,
    };
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      id: entity.id,
      title: entity.title,
      author: entity.author,
      description: entity.description,
      thumbnail: entity.thumbnail,
      rating: entity.rating,
      pageCount: entity.pageCount,
      publishedDate: entity.publishedDate,
      publisher: entity.publisher,
      previewLink: entity.previewLink,
    );
  }
}
