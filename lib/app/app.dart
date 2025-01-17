import 'package:flutter/material.dart';
import 'package:game/app/module/game/pages/achivments.dart';
import 'package:game/app/module/game/pages/all.dart';
import 'package:game/app/module/game/pages/my_mixture/my_mixtures.dart';
import 'package:game/app/module/game/pages/settings.dart';
import '../generated/assets_flame_images.dart';
import 'module/game/pages/loading.dart';
import 'module/game/pages/menu.dart';
import 'module/init/init_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magician’s Herbs',
      routes: {
        '/': (_) => const InitView(),
        Routes.loading: (_) => Loading(
              appcontext: context,
            ),
        Routes.menu: (_) => const Menu(),
        Routes.settings: (_) => const Settings(),
        Routes.achivments: (_) => const Achivments(),
        Routes.myMixtures: (_) => const MyMixturesView(),
        Routes.all: (_) => const All(),
      },
      initialRoute: '/',
    );
  }
}

class Routes {
  static const String init = '/';
  static const String end = '/end';
  static const String all = '/all';
  static const String menu = '/menu';
  static const String loading = '/loading';
  static const String achivments = '/achivments';
  static const String settings = '/settings';
  static const String myMixtures = '/my_mixtures';
}
