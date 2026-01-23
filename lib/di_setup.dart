import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final dio = Dio();

  const apiKey = 'autlulFwu0eknB3Wf8GT4FNAmK9ZkfdHLi3ZJnPg';
  dio.interceptors.addAll([
  InterceptorsWrapper(
    onRequest: (options, handler) {
      options.headers['X-Api-Key'] = apiKey;
      return handler.next(options);
    },
  ),
  PrettyDioLogger(),
  ]);

  getIt.registerSingleton<Dio>(dio);
}