import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceAssistantService {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  Function(String)? onCommandReceived;

  Future<void> initialize({required Function(String) onCommand}) async {
    onCommandReceived = onCommand;
    await Permission.microphone.request();
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
    await _speech.initialize();
  }

  void startListening() async {
    bool available = await _speech.initialize();
    if (!available) return;
    _speech.listen(
      onResult: (result) {
        if (result.finalResult && result.recognizedWords.isNotEmpty) {
          onCommandReceived?.call(result.recognizedWords);
        }
      },
      listenFor: const Duration(seconds: 10),
      pauseFor: const Duration(seconds: 3),
      cancelOnError: true,
    );
  }

  Future speak(String text) async {
    await _tts.speak(text);
  }

  void stop() => _speech.stop();
}
