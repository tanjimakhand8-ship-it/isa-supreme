import 'package:flutter/material.dart';
import '../theme.dart';

class Sidebar extends StatelessWidget {
  final String active;
  final ValueChanged<String> onSelect;
  const Sidebar({super.key, required this.active, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const items = ['Terminal', 'Chat', 'Neural Scan', 'Encryption', 'Sovereign Assets', 'Live Assistant'];
    return Container(
      width: 200,
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.only(top: 48, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MARCO', style: TextStyle(color: AppTheme.primary, fontSize: 22, fontWeight: FontWeight.bold)),
          const Text('V20.6 APEX', style: TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 30),
          ...items.map((e) => GestureDetector(
            onTap: () => onSelect(e),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: active == e ? AppTheme.primary.withOpacity(0.1) : null,
                border: active == e ? const Border(left: BorderSide(color: AppTheme.primary, width: 3)) : null,
              ),
              child: Text(e, style: TextStyle(color: active == e ? AppTheme.primary : Colors.white54, fontSize: 13)),
            ),
          )),
        ],
      ),
    );
  }
}
