import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // gerado pelo flutterfire configure
import 'screens/auth_screen.dart';
import 'screens/diary_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized() é obrigatório antes de código assíncrono no main()
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o Firebase — deve ser a primeira coisa após ensureInitialized()
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DiarioApp());
}

class DiarioApp extends StatelessWidget {
  const DiarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Diário',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD97706), // âmbar
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // AuthGuard: decide qual tela mostrar com base no estado de autenticação
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snap) {
          // Aguardando resposta do Firebase
          if (snap.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // Usuário logado → mostra o diário
          if (snap.hasData && snap.data != null) {
            return DiaryScreen(uid: snap.data!.uid);
          }
          // Não logado → mostra tela de autenticação
          return const AuthScreen();
        },
      ),
    );
  }
}