import 'package:flutter/material.dart';

import '../../../../../generated/assets_flame_images.dart';

class BaseBackButton extends StatelessWidget {
  const BaseBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AssetsFlameImages.game_empty_space, width: 50, height: 50),
          ),
        ),
      ],
    );
  }
}
