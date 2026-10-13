import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const SemijoiasApp());
}

class SemijoiasApp extends StatelessWidget {
  const SemijoiasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Semijoias',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}