import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import 'terminal.dart';
import 'chat_screen.dart';
import 'neural_scan.dart';
import 'encryption.dart';
import 'sovereign_assets.dart';
import 'live_assistant.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  String _active = 'Terminal';
  final Map<String, Widget> _screens = {
    'Terminal': const TerminalScreen(),
    'Chat': const ChatScreen(),
    'Neural Scan': const NeuralScanScreen(),
    'Encryption': const EncryptionScreen(),
    'Sovereign Assets': const SovereignAssetsScreen(),
    'Live Assistant': const LiveAssistantScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(active: _active, onSelect: (m) => setState(() => _active = m)),
          Expanded(child: _screens[_active]!),
        ],
      ),
    );
  }
}
