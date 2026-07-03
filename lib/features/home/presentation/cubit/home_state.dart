import 'package:book_house/features/home/domain/entities/book_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<BookEntity> books;

  HomeLoaded(this.books);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
