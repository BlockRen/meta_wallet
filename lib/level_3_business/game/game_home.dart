import 'dart:ui';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:meta_wallet/level_3_business/game/flame_tiled.dart';
import 'package:meta_wallet/level_3_business/game/joypad.dart';
import 'package:meta_wallet/level_3_business/game/player.dart';
import 'package:meta_wallet/level_3_business/game/direction.dart';
import 'package:tiled/tiled.dart' show ObjectGroup, TiledObject;


class GameHome extends StatefulWidget {
  const GameHome({Key? key}) : super(key: key);

  @override
  State<GameHome> createState() => _GameHomeState();
}

class _GameHomeState extends State<GameHome> {
  /// Here the game is a property which is to avoid to be rebuilt every time
  /// when the flutter tree gets rebuilt.
  final TiledGame game = TiledGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Stack(
        children: [
          GameWidget(
            // backgroundBuilder: (BuildContext context) {
            //   return Image.asset('assets/map.jpeg');
            // },
            game: game,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child:
              Joypad(onDirectionChanged: game.onJoypadDirectionChanged),
            ),
          )
        ],
      )
    );
  }
}

class TiledGame extends FlameGame with KeyboardEvents {
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final tiledMap = await TiledComponent.load('emap.tmx', Vector2.all(16));
    add(tiledMap);
    add(_player);
    _player.position = size / 2;
    camera.followComponent(_player, worldBounds: Rect.fromLTRB(0, 0, size.x, size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      _player.direction = keyDirection;
    } else if (_player.direction == keyDirection) {
      _player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}