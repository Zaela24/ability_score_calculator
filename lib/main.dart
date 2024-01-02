import 'package:ability_score_calculator/widgets/ability_score.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Point Buy Calculator',
      theme: ThemeData.dark(),
      home: const PathfinderPointBuyScreen(),
    );
  }
}
