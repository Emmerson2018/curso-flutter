import 'package:dio/dio.dart';
import '../models/noticia.dart';

class NoticiaException implements Exception {
  final String mensagem;
  const NoticiaException(this.mensagem);
  @override
  String toString() => mensagem;
}

class NoticiaService {
  // Nota: Use a URL com HTTP e inclua o /v1/ nela
  static const _apiKey  = '449eda7a7ef323008189551ef3b537d4';
  static const _baseUrl = 'http://api.mediastack.com/v1/'; 

  final Dio _dio;

  NoticiaService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(
    baseUrl:        _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
  ));

  Future<List<Noticia>> buscarNoticias(String categoria) async {
    try {
      // O endpoint correto na Mediastack é '/news'
      final resposta = await _dio.get('/news', queryParameters: {
        'categories': categoria, // Mediastack usa o plural 'categories'
        'languages': 'pt',       // Mediastack usa o plural 'languages'
        'limit': 20,             // O correto na Mediastack é 'limit'
        'access_key': _apiKey,   // O correto na Mediastack é 'access_key'
      });

      // A Mediastack responde a lista de notícias dentro da chave 'data'
      final artigos = resposta.data['data'] as List;

      return artigos
          .where((a) => a['title'] != null && a['url'] != null)
          .map((a) => Noticia.fromJson(a))
          .toList();

    } on DioException catch (e) {
      final msg = switch (e.type) {
        DioExceptionType.connectionTimeout =>
            'Conexão expirou. Verifique sua internet.',
        DioExceptionType.receiveTimeout =>
            'Servidor demorou muito para responder.',
        DioExceptionType.connectionError =>
            'Sem conexão com a internet.',
        _ => e.response?.statusCode == 401
            ? 'API Key inválida ou plano não permite HTTPS.'
            : 'Erro ao carregar notícias (${e.response?.statusCode})',
      };
      throw NoticiaException(msg);
    }
  }
}