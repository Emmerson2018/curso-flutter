import 'package:flutter/material.dart';
import 'database/app_database.dart'; // Importe do seu arquivo de banco
import 'screens/notes_list_screen.dart'; // Importe da sua tela de listagem

void main() {
  // Garante que as linhas de comunicação nativas do Flutter estejam prontas
  // antes de inicializarmos o banco de dados Drift.
  WidgetsFlutterBinding.ensureInitialized();

  // Cria a instância única (Singleton) do banco de dados do aplicativo
  final database = AppDatabase();

  runApp(MyApp(db: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  // Recebe o banco de dados por injeção de dependência no construtor
  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas Drift',
      debugShowCheckedModeBanner: false,
      
      // Configuração visual moderna com Material 3 ativo e cores dinâmicas
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber, // Cor base combinando com o tema de notas
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system, // Segue o tema do celular automaticamente

      // Abre a tela principal injetando o banco de dados nela
      home: NotesListScreen(db: db),
    );
  }
}