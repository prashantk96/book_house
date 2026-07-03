import 'package:book_house/features/auth/domain/entities/user_entity.dart';
import 'package:book_house/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CurrentUserUseCase {
  final AuthRepository repository;

  CurrentUserUseCase(this.repository);

  UserEntity? call() {
    return repository.currentUser();
  }
}
