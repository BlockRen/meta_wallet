import 'dart:ui';
import 'package:flame/input.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:meta_wallet/level_3_business/game/joypad.dart';
import 'package:meta_wallet/level_3_business/game/player.dart';
import 'package:meta_wallet/level_3_business/game/direction.dart';
import 'package:meta_wallet/level_3_business/game/world.dart';
import 'package:rive/rive.dart';

import 'character.dart';

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
    game.debugMode = true;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Stack(
        children: [
          GameWidget(
            // backgroundBuilder: (BuildContext context) {
            //   return Image.asset('assets/map.jpeg');
            // },
            // overlayBuilderMap: {
            //   'background': (ctx, game) {
            //     return Image.asset('assets/map.jpeg');
            //   }
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

class TiledGame extends FlameGame with HasCollidables, HasTappables, KeyboardEvents {
  // final Player _player = Player();
  late CharacterComponent _character;
  final World _world = World();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final tiledMap = await TiledComponent.load('emap.tmx', Vector2.all(16));

    Vector2 vec = Vector2(16*34, 16*73);

    final bg = await Sprite.load('map.jpeg');
    final image = SpriteComponent(size: vec, sprite: bg);
    add(image);

    add(tiledMap);

    final objectGroup = tiledMap.tileMap.getObjectGroupFromLayer('ObjectLayer');
    _world.addCollidables(objectGroup);
    add(_world);

    // add(_player);
    // _player.position = Vector2(vec.x / 2, vec.y / 2);
    // camera.followComponent(_player, worldBounds: Rect.fromLTRB(0, 0, vec.x, vec.y));

    final characterArtboard = await loadArtboard(RiveFile.asset('assets/rives/bluebird.riv'));
    _character = CharacterComponent(characterArtboard);
    _character.position = Vector2(vec.x / 2, vec.y / 2);
    add(_character);
    camera.followComponent(_character, worldBounds: Rect.fromLTRB(0, 0, vec.x, vec.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _character.direction = direction;
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
      _character.direction = keyDirection;
    } else if (_character.direction == keyDirection) {
      _character.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}