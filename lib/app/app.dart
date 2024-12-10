import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/quiz/quiz.dart';
import 'package:game/app/module/game/pages/quiz/quiz_end.dart';

import 'module/game/pages/about.dart';
import 'module/game/pages/gallery.dart';
import 'module/game/pages/loading.dart';
import 'module/game/pages/menu.dart';
import 'module/init/init_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codere Games',
      routes: {
        '/': (_) => const InitView(),
        Routes.loading: (_) => const Loading(),
        Routes.menu: (_) => const Menu(),
        Routes.game: (_) => const Quiz(),
        Routes.end: (_) => const EndPopUp(),
        Routes.about: (_) => const About(),
        Routes.gallery: (_) => const Gallery(),
      },
      initialRoute: '/',
    );
  }
}

class Routes {
  static const String init = '/';
  static const String end = '/end';

  static const String game = '/game';
  static const String menu = '/menu';
  static const String loading = '/loading';
  static const String gallery = '/gallery';
  static const String about = '/about';
}
