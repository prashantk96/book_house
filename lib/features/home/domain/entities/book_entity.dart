class BookEntity {
  final String id;
  final String title;
  final String author;
  final String description;
  final String thumbnail;
  final double rating;
  final int pageCount;
  final String publishedDate;
  final String publisher;
  final String previewLink;
  final double? price;

  BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnail,
    required this.rating,
    required this.pageCount,
    required this.publishedDate,
    required this.publisher,
    required this.previewLink,
    this.price,
  });
}
