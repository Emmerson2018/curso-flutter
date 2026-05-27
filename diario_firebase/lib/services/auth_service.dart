import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  // Stream que emite o usuário atual (ou null se deslogado)
  // O Firebase persiste a sessão — após fechar e abrir o app, o usuário continua logado
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User?          get currentUser      => _auth.currentUser;

  Future<UserCredential> signIn(String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email.trim(), password: password);

  Future<UserCredential> register(String email, String password) =>
      _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);

  Future<void> signOut() => _auth.signOut();

  // Mensagens amigáveis para erros do Firebase Auth (switch expression Dart 3)
  String friendlyError(FirebaseAuthException e) => switch (e.code) {
    'user-not-found'         => 'E-mail não cadastrado.',
    'wrong-password'         => 'Senha incorreta.',
    'invalid-credential'     => 'E-mail ou senha incorretos.',
    'email-already-in-use'   => 'E-mail já cadastrado. Faça login.',
    'weak-password'          => 'Senha muito fraca (mínimo 6 caracteres).',
    'invalid-email'          => 'E-mail inválido.',
    'network-request-failed' => 'Sem conexão com a internet.',
    'too-many-requests'      => 'Muitas tentativas. Tente novamente em alguns minutos.',
    _                        => 'Erro: ${e.message ?? e.code}',
  };
}