import 'package:flutter/material.dart';

import 'image_generation/screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamHost AI',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImageGenerationScreen(),
    );
  }
}
