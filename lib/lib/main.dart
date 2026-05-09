import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
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
        colorScheme: const ColorScheme.dark(primary: Colors.cyanAccent),
        scaffoldBackgroundColor: Colors.black,
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
  final TextEditingController _controller = TextEditingController();
  final AIService _ai = AIService();
  String _reply = 'Tap mic or type message...';

  void _sendText() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _reply = 'Thinking...');
    _controller.clear();
    final resp = await _ai.ask(text);
    setState(() => _reply = resp);
  }

  Future<void> _sendFile() async {
    // Pick any file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() => _reply = 'Processing file...');
      final resp = await _ai.sendFile('Analyze this', file);
      setState(() => _reply = resp);
    }
  }

  Future<void> _sendImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: source);
    if (picked != null) {
      File file = File(picked.path);
      setState(() => _reply = 'Analyzing image...');
      final resp = await _ai.sendFile('What do you see?', file);
      setState(() => _reply = resp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    _reply,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.cyanAccent),
                    onPressed: () => _sendImage(ImageSource.camera),
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo_library, color: Colors.cyanAccent),
                    onPressed: () => _sendImage(ImageSource.gallery),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.cyanAccent),
                    onPressed: _sendFile,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Message...',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _sendText(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.cyanAccent),
                    onPressed: _sendText,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
