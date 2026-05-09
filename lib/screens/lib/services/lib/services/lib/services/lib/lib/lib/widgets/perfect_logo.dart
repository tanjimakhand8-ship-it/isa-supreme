import 'package:flutter/material.dart';

class PerfectLogo extends StatefulWidget {
  final double size;
  const PerfectLogo({super.key, this.size = 84});

  @override
  State<PerfectLogo> createState() => _PerfectLogoState();
}

class _PerfectLogoState extends State<PerfectLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _PerfectLogoPainter(),
      ),
    );
  }
}

class _PerfectLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.38;
    final paint = Paint()
      ..color = const Color(0xFF6C63FF).withOpacity(0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(c, r, paint);
    final path = Path();
    path.moveTo(c.dx - r * 0.65, c.dy - r * 0.22);
    path.cubicTo(c.dx - r * 0.95, c.dy - r * 0.55, c.dx + r * 0.95, c.dy + r * 0.55, c.dx + r * 0.65, c.dy + r * 0.22);
    path.cubicTo(c.dx + r * 0.95, c.dy + r * 0.55, c.dx - r * 0.95, c.dy - r * 0.55, c.dx - r * 0.65, c.dy - r * 0.22);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFF7C9FF5)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..strokeCap = StrokeCap.round,
    );
    final tp = TextPainter(
      text: const TextSpan(
        text: 'ISA',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
