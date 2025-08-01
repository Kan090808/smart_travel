import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../services/speech_service.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _controller = TextEditingController();
  String _translated = '';

  Future<void> _translate() async {
    final text = _controller.text;
    if (text.isEmpty) return;
    final result = await GeminiService.instance.translateText(text);
    setState(() {
      _translated = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Translate')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter text'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _translate, child: const Text('Translate')),
            const SizedBox(height: 16),
            Text(_translated),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'mic',
            child: const Icon(Icons.mic),
            onPressed: () => SpeechService.instance.listenAndTranslate(_controller, _translate),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'speak',
            child: const Icon(Icons.volume_up),
            onPressed: () => SpeechService.instance.speak(_translated),
          ),
        ],
      ),
    );
  }
}
