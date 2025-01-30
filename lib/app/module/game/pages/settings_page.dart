import 'package:flutter/material.dart';

import '../../../../generated/assets_flame_images.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AssetsFlameImages.settings_BG_settings),
        ],
      ),
    );
  }
}
