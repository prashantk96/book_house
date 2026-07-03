import 'package:book_house/features/home/domain/entities/book_entity.dart';

abstract class HomeState {
  final bool isListView;
  final int selectedTab;

  const HomeState({this.isListView = true, this.selectedTab = 0});
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  const HomeLoading({super.isListView, super.selectedTab});
}

class HomeLoaded extends HomeState {
  final List<BookEntity> books;

  const HomeLoaded(this.books, {super.isListView, super.selectedTab});
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message, {super.isListView, super.selectedTab});
}
