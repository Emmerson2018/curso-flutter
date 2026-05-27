import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/tts/tts_service.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/constants/api_constants.dart';

part 'settings_screen.g.dart';

typedef SettingsData = ({double ttsRate, int gridCols});

@riverpod
class AppSettings extends _$AppSettings {
  @override
  Future<SettingsData> build() async {
    final p = await SharedPreferences.getInstance();
    return (
      ttsRate:  p.getDouble('tts_rate') ?? .5,
      gridCols: p.getInt('grid_cols')   ?? 3,
    );
  }

  Future<void> setTtsRate(double v) async {
    (await SharedPreferences.getInstance()).setDouble('tts_rate', v);
    ref.read(ttsServiceProvider).setSpeechRate(v);
    ref.invalidateSelf();
  }

  Future<void> setGridCols(int n) async {
    (await SharedPreferences.getInstance()).setInt('grid_cols', n);
    ref.invalidateSelf();
  }

  Future<void> saveUnsplashKey(String key) async {
    // Salva com a chave correta definida em ApiConstants
    await const FlutterSecureStorage()
        .write(key: ApiConstants.unsplashKeyName, value: key);
    ref.invalidate(dioClientProvider);
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: settingsAsync.when(
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erro: $e')),
        data: (s) => ListView(children: [
          ListTile(
            title: const Text('Colunas na galeria'),
            trailing: DropdownButton<int>(
              value: s.gridCols,
              items: [2, 3, 4]
                  .map((n) =>
                      DropdownMenuItem(value: n, child: Text('$n')))
                  .toList(),
              onChanged: (n) =>
                  ref.read(appSettingsProvider.notifier).setGridCols(n!),
            ),
          ),
          ListTile(
            title: const Text('Velocidade da voz'),
            subtitle: Slider(
              value:     s.ttsRate,
              min:       .1,
              max:       1.0,
              divisions: 9,
              label:     s.ttsRate.toStringAsFixed(1),
              onChanged: (v) =>
                  ref.read(appSettingsProvider.notifier).setTtsRate(v),
            ),
          ),
          ListTile(
            title:    const Text('API Key do Unsplash'),
            subtitle: const Text('Necessária para buscar fotos online'),
            trailing: const Icon(Icons.key),
            onTap:    () => _showKeyDialog(context, ref),
          ),
        ]),
      ),
    );
  }

  void _showKeyDialog(BuildContext ctx, WidgetRef ref) {
    final ctrl = TextEditingController();
    showDialog(
      context: ctx,
      builder: (c) => AlertDialog(
        title: const Text('API Key do Unsplash'),
        content: TextField(
          controller:  ctrl,
          obscureText: true,
          decoration:  const InputDecoration(
              hintText: 'Cole sua Access Key',
              border:   OutlineInputBorder()),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c),
              child: const Text('Cancelar')),
          FilledButton(
            onPressed: () async {
              await ref
                  .read(appSettingsProvider.notifier)
                  .saveUnsplashKey(ctrl.text);
              if (c.mounted) Navigator.pop(c);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
