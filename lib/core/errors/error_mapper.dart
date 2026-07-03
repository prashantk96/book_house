import 'exceptions.dart';

class ErrorMapper {
  static String map(Object error) {
    switch (error) {
      case NetworkException():
        return 'No internet connection';

      case UnauthorizedException():
        return 'Invalid credentials';

      case NotFoundException():
        return 'Data not found';

      case CacheException():
        return 'Cache error';

      default:
        return 'Something went wrong';
    }
  }
}
