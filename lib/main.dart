import 'package:flutter/material.dart';
import 'styles/themes/app_theme_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bolsify',
      theme: AppThemeLight.theme,
      home: const Scaffold(
        body: Center(child: Text('Bolsify MVP 🚀')),
      ),
    );
  }
}
