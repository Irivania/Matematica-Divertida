/// Campo de input para resposta do usuário.
import 'package:flutter/material.dart';

class AnswerInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  const AnswerInputField({required this.controller, this.onSubmitted, this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Sua resposta',
        border: OutlineInputBorder(),
      ),
      onSubmitted: onSubmitted,
    );
  }
}
