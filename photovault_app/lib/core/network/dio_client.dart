import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_client.g.dart';

class DioClient {
  late final Dio dio;

  DioClient({required String apiKey}) {
    dio = Dio(BaseOptions(
      baseUrl:        'https://api.unsplash.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Authorization': 'Client-ID $apiKey',
        'Accept-Version': 'v1',
      },
    ));

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        requestBody:  true,
        responseBody: false,
        logPrint: (o) => debugPrint('[DIO] $o'),
      ));
    }

    dio.interceptors.add(InterceptorsWrapper(
      onError: (err, handler) {
        final msg = switch (err.response?.statusCode) {
          401 => 'API Key inválida. Configure nas configurações.',
          403 => 'Limite de requisições atingido. Aguarde.',
          429 => 'Muitas requisições. Tente mais tarde.',
          _   => err.message ?? 'Erro de rede',
        };
        handler.reject(DioException(
            requestOptions: err.requestOptions, message: msg));
      },
    ));
  }
}

@Riverpod(keepAlive: true)
Future<DioClient> dioClient(DioClientRef ref) async {
  const storage = FlutterSecureStorage();
  final apiKey  = await storage.read(key: 'unsplash_api_key') ?? '';
  return DioClient(apiKey: apiKey);
}
