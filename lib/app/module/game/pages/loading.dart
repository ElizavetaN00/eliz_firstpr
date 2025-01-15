import 'package:flutter/material.dart';
import 'package:game/generated/assets_flame_images.dart';

import '../../../app.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) Navigator.pushReplacementNamed(context, Routes.menu);
      });
    });
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

class _LoopingSpinAnimationState extends State<LoopingSpinAnimation> with SingleTickerProviderStateMixin {
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
