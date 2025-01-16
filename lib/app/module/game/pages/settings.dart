import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:game/data/storage/storage.dart';

import '../../../../generated/assets_flame_images.dart';
import '../widgets/back_button/back_button.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var musicEnabled = AppStorage.musicEnabled.val;
  var soundEnabled = AppStorage.soundEnabled.val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.bg_settings_book_image,
              fit: BoxFit.cover,
            ),
            const BaseBackButton(),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  const SizedBox(height: 140),
                  Column(
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              soundEnabled = !soundEnabled;
                              AppStorage.soundEnabled.val = soundEnabled;
                            });
                          },
                          child: Image.asset(soundEnabled
                              ? AssetsFlameImages.settings_sound_on_off_button
                              : AssetsFlameImages.settings_sound_off)),
                      const SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            setState(() {
                              musicEnabled = !musicEnabled;
                              AppStorage.musicEnabled.val = musicEnabled;
                              if (musicEnabled) {
                                FlameAudio.bgm.resume();
                              } else {
                                FlameAudio.bgm.pause();
                              }
                            });
                          },
                          child: Image.asset(
                            musicEnabled
                                ? AssetsFlameImages.settings_music_on_off
                                : AssetsFlameImages
                                    .settings_music_off_oval_buttons_dark_green,
                          )),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
