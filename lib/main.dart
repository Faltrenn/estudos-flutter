import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Boa noite!"),
          ),
          body: const Text("Mas é tarde!"),
          bottomNavigationBar: const Text("Sou inútil"),
        ));
  }
}
