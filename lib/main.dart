import 'package:flutter/material.dart';
import 'package:calorio/screens/tabs.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Color.fromARGB(255, 131, 57, 0),
  ),
);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: Scaffold(
        body: const TabsScreen(),
      ),
    );
  }
}
