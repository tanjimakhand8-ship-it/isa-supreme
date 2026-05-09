import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/ai_service.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});
  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final _ai = AIService();
  String _log = 'ISA SUPREME ONLINE\nNeural fusion complete.\nWelcome, Master.\n';

  void _exec(String cmd) async {
    if (cmd.trim().isEmpty) return;
    setState(() => _log += '\n> $cmd');
    _input.clear();
    final reply = await _ai.ask(cmd);
    setState(() => _log += '\n$reply');
    _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(controller: _scroll, child: Text(_log, style: const TextStyle(color: AppTheme.primary, fontFamily: 'JetBrains Mono', fontSize: 13))),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppTheme.border))),
          child: Row(
            children: [
              Expanded(child: TextField(controller: _input, style: const TextStyle(color: AppTheme.primary), decoration: const InputDecoration.collapsed(hintText: 'Enter command...'), onSubmitted: _exec)),
              IconButton(icon: const Icon(Icons.send, color: AppTheme.primary), onPressed: () => _exec(_input.text)),
            ],
          ),
        ),
      ],
    );
  }
}
