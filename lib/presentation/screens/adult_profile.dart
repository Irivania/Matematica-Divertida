import 'package:flutter/material.dart';

class AdultProfileScreen extends StatelessWidget {
  const AdultProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil do Adulto')),
      body: const Center(
        child: CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage('assets/images/adult_avatar.png'),
        ),
      ),
    );
  }
}