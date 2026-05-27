import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/photo/domain/entities/photo.dart';

part 'tts_service.g.dart';

enum TtsState { idle, playing, paused, stopped }

class TtsService {
  final _tts = FlutterTts();
  TtsState _state = TtsState.idle;
  TtsState get state => _state;

  Future<void> init() async {
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _tts.setStartHandler(()      => _state = TtsState.playing);
    _tts.setCompletionHandler(() => _state = TtsState.idle);
    _tts.setCancelHandler(()    => _state = TtsState.stopped);
    _tts.setPauseHandler(()     => _state = TtsState.paused);
    _tts.setErrorHandler((msg)  => debugPrint('TTS: $msg'));
  }

  Future<void> speakPhoto(Photo photo) async {
    final parts = <String>[];
    if (photo.caption?.isNotEmpty == true)
        parts.add('Legenda: ${photo.caption}');
    if (photo.audioDescription?.isNotEmpty == true)
        parts.add('Audiodescrição: ${photo.audioDescription}');
    if (photo.photographerName?.isNotEmpty == true)
        parts.add('Fotógrafo: ${photo.photographerName}');
    await _tts.stop();
    await _tts.speak(
        parts.isEmpty ? 'Esta foto não possui descrição.' : parts.join('. '));
  }

  Future<void> pause()                async => _tts.pause();
  Future<void> stop()                 async => _tts.stop();
  Future<void> setSpeechRate(double r) async => _tts.setSpeechRate(r.clamp(.1, 1.0));
  void dispose() => _tts.stop();
}

@Riverpod(keepAlive: true)
TtsService ttsService(TtsServiceRef ref) {
  final s = TtsService();
  s.init();
  ref.onDispose(s.dispose);
  return s;
}
