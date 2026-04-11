/// Enum para os tipos de modo disponíveis no app
/// Modo Criança: desafios lúdicos
/// Modo Adulto: desafios avançados
import 'package:flutter/material.dart';

enum ModeType { child, adult }

/// Tela principal de seleção de modo (Criança ou Adulto)
/// Exibe cards estilizados para cada modo e um botão para iniciar

class ModeSelectionPage extends StatefulWidget {
  final void Function(ModeType)? onModeSelected;
  const ModeSelectionPage({super.key, this.onModeSelected});

  @override
  State<ModeSelectionPage> createState() => _ModeSelectionPageState();
}

/// Estado da tela de seleção de modo
class _ModeSelectionPageState extends State<ModeSelectionPage> {
  /// Armazena o modo selecionado pelo usuário
  ModeType? selectedMode;

  @override
  Widget build(BuildContext context) {
    // Gradiente de fundo da tela
    final LinearGradient backgroundGradient = const LinearGradient(
      colors: [Color(0xFF6DC6F6), Color(0xFF1565C0)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    // Gradientes dos cards
    final List<Color> childModeGradient = const [Color(0xFFFFE082), Color(0xFFFF9800)];
    final List<Color> adultModeGradient = const [Color(0xFF64B5F6), Color(0xFF1976D2)];

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Stack(
          children: [
            // Elementos decorativos de fundo
            const _BackgroundDecor(),
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  // Título e subtítulo
                  const _Header(),
                  const SizedBox(height: 36),
                  // Cards de seleção de modo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        // Card do modo criança
                        Expanded(
                          child: ModeCardWidget(
                            title: 'Modo Criança',
                            gradientColors: childModeGradient,
                            isSelected: selectedMode == ModeType.child,
                            onTap: () => setState(() => selectedMode = ModeType.child),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '2 + 3',
                                  style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  '🧸',
                                  style: TextStyle(fontSize: 40),
                                ),
                              ],
                            ),
                            bottomLabel: 'Modo Criança',
                            bottomLabelColor: Color(0xFFFF9800),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Card do modo adulto
                        Expanded(
                          child: ModeCardWidget(
                            title: 'Modo Adulto',
                            gradientColors: adultModeGradient,
                            isSelected: selectedMode == ModeType.adult,
                            onTap: () => setState(() => selectedMode = ModeType.adult),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '12²',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'monospace',
                                    shadows: [
                                      Shadow(
                                        blurRadius: 8,
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12),
                                Icon(Icons.school, color: Colors.white, size: 36),
                              ],
                            ),
                            bottomLabel: 'Modo Adulto',
                            bottomLabelColor: Color(0xFF1976D2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  // Botão para iniciar o jogo
                  _StartButton(
                    enabled: selectedMode != null,
                    onPressed: selectedMode != null
                        ? () {
                            if (selectedMode != null) {
                              Navigator.pop(context, selectedMode);
                            }
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Matemática Divertida +',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Colors.black26,
                offset: Offset(0, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Escolha o Modo!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class ModeCardWidget extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;
  final String bottomLabel;
  final Color bottomLabelColor;

  const ModeCardWidget({
    required this.title,
    required this.gradientColors,
    required this.isSelected,
    required this.onTap,
    required this.child,
    required this.bottomLabel,
    required this.bottomLabelColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 36;
    const double cardHeight = 210;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  color: gradientColors.last.withOpacity(0.4),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: bottomLabelColor.withOpacity(0.92),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                  child: Text(
                    bottomLabel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onPressed;
  const _StartButton({required this.enabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: enabled ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
          backgroundColor: const Color(0xFF43A047),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 8,
          textStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('COMEÇAR'),
      ),
    );
  }
}

/// Elementos decorativos de fundo (números, símbolos, etc)
class _BackgroundDecor extends StatelessWidget {
  const _BackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _DecorPainter(),
        size: Size.infinite,
      ),
    );
  }
}

/// Painter para desenhar elementos decorativos no fundo
class _DecorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.07);
    final textStyle = const TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
      fontFamily: 'monospace',
    );
    final symbols = ['+', '7', 'π', '÷', 'x', '√', '3', '∑', '9', '4'];
    final positions = [
      Offset(size.width * 0.15, size.height * 0.18),
      Offset(size.width * 0.7, size.height * 0.12),
      Offset(size.width * 0.5, size.height * 0.32),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.8, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.8),
    ];
    for (var i = 0; i < positions.length; i++) {
      final textSpan = TextSpan(text: symbols[i % symbols.length], style: textStyle);
      final tp = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, positions[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
