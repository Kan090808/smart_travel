import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

class SpeechService {
  SpeechService._private();
  static final SpeechService instance = SpeechService._private();

  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  Future<void> listenAndTranslate(TextEditingController controller, Function onDone) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (result) {
        controller.text = result.recognizedWords;
      }, onSoundLevelChange: null, cancelOnError: true, listenFor: const Duration(seconds: 10));
      await Future.delayed(const Duration(seconds: 10));
      _speech.stop();
      await onDone();
    }
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }
}
