import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String activeModule;
  final ValueChanged<String> onSelectModule;
  const Sidebar({super.key, required this.activeModule, required this.onSelectModule});

  @override
  Widget build(BuildContext context) {
    const modules = ['Terminal', 'Chat', 'Neural Scan', 'Encryption', 'Sovereign Assets', 'Live Assistant'];
    return Container(
      width: 220,
      color: const Color(0xFF0D0D0D),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MARCO', style: TextStyle(color: Color(0xFF00FF41), fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('V20.6 APEX', style: TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 30),
          ...modules.map((module) => GestureDetector(
            onTap: () => onSelectModule(module),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: activeModule == module ? const Color(0xFF00FF41).withOpacity(0.1) : Colors.transparent,
                border: activeModule == module ? const Border(left: BorderSide(color: Color(0xFF00FF41), width: 3)) : null,
              ),
              child: Text(module, style: TextStyle(
                color: activeModule == module ? const Color(0xFF00FF41) : Colors.white54,
                fontWeight: activeModule == module ? FontWeight.bold : FontWeight.normal,
              )),
            ),
          )).toList(),
        ],
      ),
    );
  }
}
