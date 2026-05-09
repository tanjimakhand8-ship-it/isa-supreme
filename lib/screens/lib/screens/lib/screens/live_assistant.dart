import 'package:flutter/material.dart';

class LiveAssistantScreen extends StatelessWidget {
  const LiveAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic, size: 64, color: Color(0xFF00FF41)),
          SizedBox(height: 20),
          Text('LIVE ASSISTANT',
              style: TextStyle(color: Color(0xFF00FF41), fontSize: 18)),
          Text('Real-time voice link active.',
              style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
