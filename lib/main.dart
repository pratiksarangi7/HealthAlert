import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medico_app/screens/medico_items.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 80, 250, 208),
        ),
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 0, 101, 164),
        ),
      ),
      home: const MedicoItemsScreen(),
    );
  }
}
