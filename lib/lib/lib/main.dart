import 'package:flutter/material.dart';
import 'services/ai_service.dart';

void main() => runApp(const IsaApp());

class IsaApp extends StatelessWidget {
  const IsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISA SUPREME',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Colors.cyanAccent),
      ),
      home: const ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _ai = AIService();
  final List<Map<String, String>> _messages = [];

  void _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add({"role": "user", "content": text}));
    _controller.clear();
    setState(() => _messages.add({"role": "isa", "content": "..."}));
    final reply = await _ai.ask(text);
    setState(() {
      _messages.removeLast();
      _messages.add({"role": "isa", "content": reply});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final msg = _messages[i];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.cyanAccent.withOpacity(0.2) : Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['content']!, style: TextStyle(color: isUser ? Colors.white : Colors.cyanAccent)),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(hintText: 'Message...', hintStyle: TextStyle(color: Colors.white38), border: OutlineInputBorder()),
                    onSubmitted: (_) => _send(),
                  ),
                ),
              ),
              IconButton(icon: const Icon(Icons.send, color: Colors.cyanAccent), onPressed: _send),
            ],
          ),
        ],
      ),
    );
  }
}
