import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AvatarAnimation extends StatelessWidget {
  const AvatarAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avatar"),
      ),
      body: const Center(
        child: RiveAnimation.asset(
          'assets/tom_morello.riv',
          fit: BoxFit.fitWidth,
          artboard: 'Artboard',
          animations: ['Idle', 'Rage'],
        ),
      ),
    );
  }
}