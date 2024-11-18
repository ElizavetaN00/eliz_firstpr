import 'package:flutter/material.dart';

import 'module/init/init_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spinaway Riches',
      routes: {'/': (_) => const InitView()},
      initialRoute: '/',
    );
  }
}
