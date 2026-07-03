import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_client.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  DioClient get dioClient => DioClient();

  @lazySingleton
  Dio get dio => dioClient.dio;
}
