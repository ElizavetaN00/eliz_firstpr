import 'package:flutter/material.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../app.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, required this.appcontext});
  final BuildContext appcontext;
  @override
  State<Loading> createState() => _LoadingState();
}

void printImageCacheInfo() {
  PaintingBinding.instance.imageCache.maximumSize = 2000; // 2000 объектов
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      300 * 1024 * 1024; // 300 МБ
}

class _LoadingState extends State<Loading> {
  @override
  void didChangeDependencies() async {
    printImageCacheInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var imageList = [
        AssetsFlameImages.bg_achievements_bookshelf,
        AssetsFlameImages
            .bg_book_and_cups_of_magic_teas_in_a_mysterious_setting,
        AssetsFlameImages.bg_createnew,
        AssetsFlameImages.bg_magical_library_bookshelf_gemstones,
        AssetsFlameImages.bg_magicians_herbs,
        AssetsFlameImages.bg_my_mixtures_books_and_teapot,
        AssetsFlameImages.bg_settings_book_image,
        AssetsFlameImages
            .game_a_capsule_icon_with_a_vibrant_colorful_design_likely_used_to_represent_health_or_wellness_in_a_digital_interface,
        AssetsFlameImages.game_a_cup_of_tea_on_a_plate,
        AssetsFlameImages.game_lemon_slice,
        AssetsFlameImages.game_pill,
        AssetsFlameImages.game_rainbow_leaf,
        AssetsFlameImages.game_rainbow_leaf_1,
        AssetsFlameImages.game_rose,
        AssetsFlameImages.game_rose_illustration,
        AssetsFlameImages.game_lemon_slice,
        AssetsFlameImages.game_lemon_slice_on_yellow_background,
        AssetsFlameImages.game_tea_cup_with_leaf_in_it,
      ];

      for (var element in AssetsFlameImages.all) {
        await precacheImage(AssetImage(element), widget.appcontext);
      }
      await Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pushReplacementNamed(context, Routes.menu);
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AssetsFlameImages.bg_magicians_herbs,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LoopingSpinAnimation(
                  child: Image.asset(
                    AssetsFlameImages.game_circle,
                    height: 50,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoopingSpinAnimation extends StatefulWidget {
  final Widget child;
  const LoopingSpinAnimation({super.key, required this.child});

  @override
  _LoopingSpinAnimationState createState() => _LoopingSpinAnimationState();
}

class _LoopingSpinAnimationState extends State<LoopingSpinAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration of one full spin
    )..repeat(); // Repeat the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.141592653589793, // Full rotation
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
