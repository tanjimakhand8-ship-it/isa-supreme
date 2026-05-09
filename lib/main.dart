import 'package:flutter/material.dart';

void main() => runApp(const IsaCore());

class IsaCore extends StatelessWidget {
  const IsaCore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISA CORE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(primary: Colors.cyanAccent),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.memory, size: 80, color: Colors.cyanAccent),
              SizedBox(height: 20),
              Text('ISA SUPREME', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text('Core system online', style: TextStyle(color: Colors.white54)),
            ],
          ),
        ),
      ),
    );
  }
}
