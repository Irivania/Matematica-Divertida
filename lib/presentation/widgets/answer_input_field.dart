/// Campo de input para resposta do usuário.
import 'package:flutter/material.dart';

class AnswerInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  const AnswerInputField({required this.controller, this.onSubmitted, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Sua resposta',
        border: OutlineInputBorder(),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
