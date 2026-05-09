import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/main_shell.dart';

void main() => runApp(const IsaApp());

class IsaApp extends StatelessWidget {
  const IsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISA SUPREME',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainShell(),
    );
  }
}
