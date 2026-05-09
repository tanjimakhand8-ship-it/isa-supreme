import 'package:flutter/material.dart';

class EncryptionScreen extends StatefulWidget {
  const EncryptionScreen({super.key});

  @override
  State<EncryptionScreen> createState() => _EncryptionScreenState();
}

class _EncryptionScreenState extends State<EncryptionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animController);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('APEX CRYPTO SUITE',
              style: TextStyle(
                  color: Color(0xFF00FF41),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const Text('SYSTEM STATUS: OPTIMAL // MARCO V20.6 APEX',
              style: TextStyle(color: Colors.white54, fontSize: 11)),
          const SizedBox(height: 30),
          const Text('Inputs',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1A1A1A)),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: [
                Text('Input Sequence:',
                    style: TextStyle(color: Colors.white30, fontSize: 12)),
                Spacer(),
                Text('[empty]',
                    style: TextStyle(color: Colors.white30, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1A1A1A)),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: [
                Text('Encrypted Payload:',
                    style: TextStyle(color: Colors.white30, fontSize: 12)),
                Spacer(),
                Text('[empty]',
                    style: TextStyle(color: Colors.white30, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFF00FF41)
                          .withOpacity(0.5 + _animation.value * 0.5)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    const Text(
                        'CIPHER: AES-256-GCM // X-NODE_TUNNEL',
                        style: TextStyle(
                            color: Color(0xFF00FF41), fontSize: 12)),
                    const SizedBox(height: 10),
                    const Text('ENTROPY: 99.98% [VETERAN-STABLE]',
                        style: TextStyle(
                            color: Color(0xFF00FF41), fontSize: 12)),
                    const SizedBox(height: 20),
                    Icon(Icons.lock,
                        size: 48,
                        color: const Color(0xFF00FF41).withOpacity(0.8)),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          const Center(
            child: Text('APEX NEURAL INTERFACE\nV20.6',
                style: TextStyle(color: Colors.white30, fontSize: 10)),
          ),
        ],
      ),
    );
  }
}
