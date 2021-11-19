import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AvatarAnimation extends StatefulWidget {
  const AvatarAnimation({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AvatarAnimationState();
}

class _AvatarAnimationState extends State<AvatarAnimation> {
  // Controller for playback
  late RiveAnimationController _controller;

  // Toggles between play and pause animation states
  void _togglePlay() => setState(() {
    _controller.isActive = !_controller.isActive;
  });

  /// Tracks if the animation is playing by whether controller is running
  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    super.initState();
    _controller = SimpleAnimation('Rage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Avatar"),
      ),
      body: Center(
        child: RiveAnimation.asset(
          'assets/tom_morello.riv',
          fit: BoxFit.fitWidth,
          artboard: 'Artboard',
          controllers: [_controller],
          onInit: (_) => setState(() {
            _controller.isActive = false;
          }),
          // animations: ['Idle', 'Rage'],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePlay,
        tooltip: isPlaying ? 'Pause' : 'Play',
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}