import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bolsify 🪙')),
      body: const Center(
        child: Text('Bienvenido a Bolsify', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
