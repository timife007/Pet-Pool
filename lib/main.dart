import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_pool/ui/home.dart';

void main() {
  runApp(const ProviderScope(
      child: MaterialApp(
    home: MainApp(),
  )));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Home();
  }
}
