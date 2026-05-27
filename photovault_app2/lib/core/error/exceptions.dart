// Exceções da infraestrutura — lançadas nas camadas Data
class NetworkException  implements Exception {
  final String message;
  const NetworkException(this.message);
}
class CacheException    implements Exception {
  final String message;
  const CacheException(this.message);
}