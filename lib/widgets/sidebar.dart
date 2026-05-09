import 'package:flutter/material.dart';
import '../theme.dart';

class Sidebar extends StatelessWidget {
  final String active;
  final ValueChanged<String> onTap;
  const Sidebar({super.key, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const items = ['Terminal']; // পরে আরও মডিউল যোগ করতে পারবি

    return Container(
      width: 190,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: AppTheme.matrixGreen, width: 0.5),
        ),
        color: Color(0xFF0A0A0A),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 48, left: 16, bottom: 24),
            child: Text(
              'ISA\nSUPREME',
              style: TextStyle(
                color: AppTheme.matrixGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...items.map((module) => GestureDetector(
                onTap: () => onTap(module),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    color: active == module
                        ? AppTheme.matrixGreen.withOpacity(0.1)
                        : Colors.transparent,
                    border: active == module
                        ? const Border(
                            left: BorderSide(color: AppTheme.matrixGreen, width: 3))
                        : null,
                  ),
                  child: Text(
                    module,
                    style: TextStyle(
                      color: active == module ? AppTheme.matrixGreen : Colors.white54,
                      fontSize: 13,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
