import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Wrapper de acesso seguro — centraliza o uso do flutter_secure_storage
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),  // RSA OAEP + AES-GCM por padrão (v10+)
  );

  static Future<String?> read(String key) => _storage.read(key: key);
  static Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);
  static Future<void> delete(String key) => _storage.delete(key: key);
}