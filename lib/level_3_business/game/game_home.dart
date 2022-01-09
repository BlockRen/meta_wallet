import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:meta_wallet/level_3_business/game/world/boundaries.dart';
import 'package:rive/rive.dart';
import 'package:forge2d/forge2d.dart';
import 'character.dart';
import 'package:meta_wallet/level_3_business/game/world/things.dart';
import 'package:meta_wallet/level_3_business/game/joypad.dart';
import 'package:meta_wallet/level_3_business/game/direction.dart';
import 'package:meta_wallet/level_3_business/game/world/things.dart';

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

class TiledGame extends Forge2DGame with HasTappables { // KeyboardEvents
  // final Player _player = Player();
  late CharacterComponent _character;
  final Things _things = Things();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // world boundaries
    Vector2 gameSize = screenToWorld(camera.viewport.effectiveSize);
    addAll(Boundaries.createBoundaries(gameSize));

    Vector2 vec = Vector2(16*34, 16*73);
    // background image
    final bg = await Sprite.load('map.jpeg');
    final image = SpriteComponent(size: vec, sprite: bg);
    add(image);

    // tiled map
    final tiledMap = await TiledComponent.load('emap.tmx', Vector2.all(16));
    add(tiledMap);

    final objectGroup = tiledMap.tileMap.getObjectGroupFromLayer('ObjectLayer');
    // _things.addCollidables(objectGroup);
    // add(_things);

    // character
    final characterArtboard = await loadArtboard(RiveFile.asset('assets/rives/bluebird.riv'));
    _character = CharacterComponent(characterArtboard);
    _character.position = Vector2(vec.x / 2, vec.y / 2);
    add(_character);
    // camera follow the character
    camera.followComponent(_character, worldBounds: Rect.fromLTRB(0, 0, vec.x, vec.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _character.direction = direction;
  }
}