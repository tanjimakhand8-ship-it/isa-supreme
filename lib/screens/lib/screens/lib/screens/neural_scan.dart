import 'package:flutter/material.dart';

class NeuralScanScreen extends StatefulWidget {
  const NeuralScanScreen({super.key});

  @override
  State<NeuralScanScreen> createState() => _NeuralScanScreenState();
}

class _NeuralScanScreenState extends State<NeuralScanScreen> {
  double _progress = 0;
  bool _scanning = false;

  void _startScan() {
    setState(() {
      _scanning = true;
      _progress = 0;
    });
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 200));
      if (!_scanning) return false;
      setState(() {
        _progress += 0.02;
        if (_progress >= 1) {
          _progress = 1;
          _scanning = false;
        }
      });
      return _progress < 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VULNERABILITY ENGINE',
            style: TextStyle(
              color: Color(0xFF00FF41),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const Text(
            'APEX DEEP PACKET INSPECTION // V20.6',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text('ANALYSIS PROGRESS',
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
              const Spacer(),
              Text('${(_progress * 100).toInt()}%',
                  style: const TextStyle(color: Color(0xFF00FF41), fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey[900],
            color: const Color(0xFF00FF41),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStat('1,024', 'PACKETS/S'),
              _buildStat('2.4 GB/s', 'THROUGHPUT'),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _scanning ? null : _startScan,
              icon: const Icon(Icons.search, color: Colors.black),
              label: const Text('INITIALIZE SCAN',
                  style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF41),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('LIVE ANALYSIS OUTPUT',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['ALL', 'ANALYZED', 'FAILED', 'HIGH', 'LOW']
                .map((e) => Chip(
                      label: Text(e,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 11)),
                      backgroundColor: Colors.white10,
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text('RECENT AUDIT LOGS',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF1A1A1A)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            child: const Text('AWAITING SEQUENCE INITIALIZATION...',
                style: TextStyle(color: Colors.white30, fontSize: 12)),
          ),
          const Spacer(),
          const Text(
            'SUPREME MASTER  TANZIM AKHAND LAMIM\n'
            'NEXUS STATE  V20.6_APEX_ONLINE',
            style: TextStyle(color: Colors.white30, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Color(0xFF00FF41),
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }
}
