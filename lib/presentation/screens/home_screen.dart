import 'package:flutter/material.dart';
import '../../domain/entities/game_mode.dart';
import 'dart:math';
import 'package:matematica_divertida/presentation/screens/_animated_gradient_button.dart';
import 'package:matematica_divertida/presentation/screens/_animated_bg_painter.dart';

enum _ModeType { child, adult }

class HomeScreen extends StatefulWidget {
  final void Function(GameMode) onModeSelected;
  const HomeScreen({required this.onModeSelected, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  _ModeType? selectedMode;
  bool showContent = false;
  late final AnimationController _bgAnimController;
  late final Animation<double> _bgAnim;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => showContent = true);
    });
  }

