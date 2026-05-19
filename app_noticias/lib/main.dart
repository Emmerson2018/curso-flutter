import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'models/noticia.dart';
import 'services/noticia_service.dart';

void main() => runApp(const NewsApp());

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'News Reader',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const NewsScreen(),
  );
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {

  late TabController       _tabCtrl;
  final NoticiaService     _service = NoticiaService();
  final Map<String, Future<List<Noticia>>> _futures = {};

  static const categorias = [
    ('technology', '💻 Tech'),
    ('science',    '🔬 Ciência'),
    ('sports',     '⚽ Esportes'),
    ('health',     '❤️ Saúde'),
    ('business',   '📈 Negócios'),
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: categorias.length, vsync: this);
    // Carrega a primeira categoria imediatamente
    _carregarCategoria(categorias.first.$1);
    // Carrega as demais ao trocar de aba
    _tabCtrl.addListener(() {
      if (_tabCtrl.indexIsChanging) {
        _carregarCategoria(categorias[_tabCtrl.index].$1);
      }
    });
  }

  void _carregarCategoria(String cat) {
    if (!_futures.containsKey(cat)) {
      setState(() {
        _futures[cat] = _service.buscarNoticias(cat);
      });
    }
  }

  Future<void> _recarregar(String cat) {
    setState(() {
      // Remove o cache forçando nova requisição
      _futures.remove(cat);
      _futures[cat] = _service.buscarNoticias(cat);
    });
    return _futures[cat]!;
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📰 News Reader'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabCtrl,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: categorias.map((c) => Tab(text: c.$2)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: categorias.map((c) => _buildTabContent(c.$1)).toList(),
      ),
    );
  }

  Widget _buildTabContent(String cat) {
    final future = _futures[cat];
    if (future == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // FutureBuilder: constrói a UI baseado no estado do Future
    return FutureBuilder<List<Noticia>>(
      future: future,
      builder: (ctx, snapshot) {
        // snapshot.connectionState: waiting, active, done
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _buildErro(snapshot.error.toString(), cat);
        }

        final noticias = snapshot.data ?? [];
        if (noticias.isEmpty) {
          return const Center(child: Text('Nenhuma notícia disponível.'));
        }

        // RefreshIndicator: arraste para baixo para recarregar
        return RefreshIndicator(
          onRefresh: () => _recarregar(cat),
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: noticias.length,
            itemBuilder: (ctx, i) => _buildCard(noticias[i]),
          ),
        );
      },
    );
  }

  Widget _buildCard(Noticia noticia) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _abrirUrl(noticia.urlArtigo),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem com cache e placeholder
            if (noticia.urlImagem != null)
              CachedNetworkImage(
                imageUrl:    noticia.urlImagem!,
                height:      180,
                width:       double.infinity,
                fit:         BoxFit.cover,
                placeholder: (_, _) => Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator())),
                errorWidget:  (_, _, _) => Container(
                    height: 100, color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported)),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noticia.titulo,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    noticia.descricao,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(noticia.fonte,
                          style: const TextStyle(fontSize: 12, color: Colors.blue)),
                      const Spacer(),
                      Text(
                        _formatarData(noticia.publicadaEm),
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErro(String mensagem, String cat) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(mensagem, textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => _recarregar(cat),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  // Abre a URL no navegador do dispositivo
  Future<void> _abrirUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não foi possível abrir o artigo.')),
        );
      }
    }
  }

  String _formatarData(DateTime data) {
    final agora = DateTime.now();
    final diff  = agora.difference(data);
    if (diff.inHours  < 1)  return 'há ${diff.inMinutes}min';
    if (diff.inHours  < 24) return 'há ${diff.inHours}h';
    return 'há ${diff.inDays}d';
  }
}