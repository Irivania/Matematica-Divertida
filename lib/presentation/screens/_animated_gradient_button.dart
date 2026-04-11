import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final bool enabled;
  final VoidCallback? onPressed;
  const AnimatedGradientButton({required this.enabled, required this.onPressed, super.key});

  @override
  State<AnimatedGradientButton> createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return GestureDetector(
          onTap: widget.enabled ? widget.onPressed : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.enabled
                    ? [
                        Color.lerp(const Color(0xFFFFB347), const Color(0xFF43E97B), t)!,
                        Color.lerp(const Color(0xFF43E97B), const Color(0xFF38F9D7), t)!,
                      ]
                    : [Colors.grey.shade300, Colors.grey.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: widget.enabled
                  ? [
                      BoxShadow(
                        color: Colors.greenAccent.withOpacity(0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
                const SizedBox(width: 8),
                Text(
                  'COMEÇAR',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: widget.enabled ? Colors.white : Colors.grey.shade600,
                    letterSpacing: 1.2,
                    shadows: widget.enabled
                        ? [
                            Shadow(
                              blurRadius: 8,
                              color: Colors.greenAccent.withOpacity(0.3),
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}