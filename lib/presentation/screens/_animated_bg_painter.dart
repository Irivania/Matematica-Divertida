import 'package:flutter/material.dart';
import 'dart:math';

class _AnimatedBgPainter extends CustomPainter {
  final double animValue;
  _AnimatedBgPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    // Gradiente animado
    final gradient = LinearGradient(
      colors: [
        Color.lerp(const Color(0xFF43E97B), const Color(0xFF38F9D7), animValue)!,
        Color.lerp(const Color(0xFFB3E5FC), const Color(0xFF1976D2), animValue)!,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    final rect = Offset.zero & size;
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Partículas/brilhos
    final particlePaint = Paint()..color = Colors.white.withOpacity(0.13);
    final rand = Random(1234);
    for (int i = 0; i < 18; i++) {
      final dx = rand.nextDouble() * size.width;
      final dy = rand.nextDouble() * size.height;
      final r = 16 + rand.nextDouble() * 18 * (0.7 + 0.3 * animValue);
      canvas.drawCircle(Offset(dx, dy), r, particlePaint);
    }
  }

  @override
  bool shouldRepaint(_AnimatedBgPainter oldDelegate) => oldDelegate.animValue != animValue;
}