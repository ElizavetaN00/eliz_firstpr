import 'package:flutter/material.dart';

import 'module/init/init_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Endless Dragon',
      routes: {'/': (_) => const InitView()},
      initialRoute: '/',
    );
  }
}
