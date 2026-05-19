import 'package:flutter/material.dart';

// main() é o ponto de entrada de todo app Dart/Flutter
// runApp() inicia o Flutter e define o widget raiz
void main() {
  runApp(const CartaoApp());
}

// StatelessWidget: widget sem estado — não muda após renderizado
// O "extends" diz que CartaoApp É um StatelessWidget
class CartaoApp extends StatelessWidget {
  const CartaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget raiz que configura temas,
    // rotas e o "esqueleto" Material Design do app
    return MaterialApp(
      title: 'Cartão de Visita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme gera toda a paleta de cores a partir de uma cor-semente
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A2E),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const CartaoScreen(),
    );
  }
}

class CartaoScreen extends StatelessWidget {
  const CartaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold provê a estrutura visual básica (fundo, AppBar, etc)
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        // SafeArea evita que o conteúdo fique atrás da câmera ou barra do sistema
        child: SingleChildScrollView(
          // SingleChildScrollView permite scroll se o conteúdo for maior que a tela
          padding: const EdgeInsets.all(24),
          child: Column(
            // Column empilha widgets verticalmente
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // ── FOTO DE PERFIL ─────────────────────────────
              // CircleAvatar exibe uma imagem/ícone em forma circular
              CircleAvatar(
                radius: 64,
                backgroundImage: AssetImage('assets/images/foto.jpg'),
                backgroundColor: Colors.indigo,
              ),
              const SizedBox(height: 20),

              // ── NOME ───────────────────────────────────────
              const Text(
                'Seu Nome Aqui',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),

              // ── PROFISSÃO ──────────────────────────────────
              const Text(
                'Desenvolvedor Flutter',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF7C83FD),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),

              // ── LOCALIZAÇÃO ────────────────────────────────
              // Row empilha widgets horizontalmente
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.location_on, size: 14, color: Colors.white54),
                  SizedBox(width: 4),
                  Text('Manaus, AM — Brasil',
                      style: TextStyle(color: Colors.white54, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 28),

              // ── SEPARADOR ──────────────────────────────────
              const Divider(color: Colors.white12),
              const SizedBox(height: 24),

              // ── BIO ─────────────────────────────────────────
              const Text(
                'Apaixonado por criar experiências incríveis com código. '
                'Especialista em Flutter e UI/UX mobile.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.6,  // height é o espaçamento entre linhas
                ),
              ),
              const SizedBox(height: 28),

              // ── HABILIDADES ────────────────────────────────
              _buildSkillChips(),
              const SizedBox(height: 32),

              // ── LINKS SOCIAIS ───────────────────────────────
              _buildSocialLinks(),
              const SizedBox(height: 28),

              // ── BOTÃO DE CONTATO ────────────────────────────
              SizedBox(
                width: double.infinity,  // ocupa toda a largura disponível
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Por enquanto apenas mostra um SnackBar
                    // No App 6 vamos abrir URL de verdade com url_launcher
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('📧 Mensagem enviada!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.mail_outline),
                  label: const Text('Entrar em Contato'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C83FD),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // Extraímos widgets complexos em métodos privados (_build...)
  // para manter o build() principal legível
  Widget _buildSkillChips() {
    const skills = ['Flutter', 'Dart', 'Firebase', 'UI/UX', 'Git'];

    // Wrap é como Row, mas quebra a linha quando não há mais espaço
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: skills.map((skill) {
        // .map() transforma cada item da lista em um Widget
        return Chip(
          label: Text(skill,
              style: const TextStyle(fontSize: 12, color: Colors.white70)),
          backgroundColor: const Color(0xFF16213E),
          side: const BorderSide(color: Color(0xFF7C83FD), width: 1),
        );
      }).toList(),
    );
  }

  Widget _buildSocialLinks() {
    final sociais = [
      {'icon': Icons.code, 'label': 'github.com/emmerson'},
      {'icon': Icons.business, 'label': 'linkedin.com/in/emmerson'},
      {'icon': Icons.phone, 'label': '+55 92 99225-0550'},
    ];

    return Column(
      children: sociais.map((s) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(s['icon'] as IconData, size: 16,
                color: const Color(0xFF7C83FD)),
            const SizedBox(width: 8),
            Text(s['label'] as String,
                style: const TextStyle(color: Color.fromARGB(179, 228, 227, 227))),
          ],
        ),
      )).toList(),
    );
  }
}