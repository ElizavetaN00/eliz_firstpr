import 'package:flutter/material.dart';

import '../../../../generated/assets_flame_images.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AssetsFlameImages.About_the_application_BG_About_the_application,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 60,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    AssetsFlameImages.About_the_application_button_close,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
