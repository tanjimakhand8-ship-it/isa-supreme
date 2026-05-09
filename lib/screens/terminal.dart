import 'package:flutter/material.dart';
import '../theme.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController _input = TextEditingController();
  final ScrollController _scroll = ScrollController();
  String _log = 'ISA SUPREME ONLINE\n'
      'Neural fusion complete.\n'
      'Welcome back, Master Tanzim Akhand Lamim.\n'
      'Standing by.\n';

  void _execute(String cmd) {
    if (cmd.trim().isEmpty) return;
    setState(() {
      _log += '\n> $cmd';
      _log += '\nISA: Command received. (Backend offline)';
    });
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scroll.jumpTo(_scroll.position.maxScrollExtent));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              controller: _scroll,
              child: Text(
                _log,
                style: const TextStyle(
                  color: AppTheme.matrixGreen,
                  fontFamily: 'JetBrains Mono',
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppTheme.border)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  style: const TextStyle(color: AppTheme.matrixGreen),
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter command...',
                    hintStyle: TextStyle(color: Colors.white30),
                  ),
                  onSubmitted: _execute,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: AppTheme.matrixGreen),
                onPressed: () => _execute(_input.text),
              ),
              IconButton(
                icon: const Icon(Icons.mic, color: AppTheme.matrixGreen),
                onPressed: () {
                  // পরে ভয়েস যোগ হবে
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
