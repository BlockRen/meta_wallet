import 'dart:math';
import 'dart:ui';
import 'package:flame/particles.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:forge2d/forge2d.dart';
import 'character.dart';
import 'package:meta_wallet/level_1_core/storage/file_storage.dart';
import 'package:meta_wallet/level_3_business/game/world/boundaries.dart';
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

class TiledGame extends Forge2DGame with HasTappables, KeyboardEvents {
  late Character _character;
  // final Things _things = Things();

  TiledGame() : super(
    gravity: Vector2.zero(),
    zoom: 1
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    Vector2 vec = Vector2(16*34, 16*73);
    // background image
    final bg = await Sprite.load('map.jpeg');
    final image = SpriteComponent(size: vec, sprite: bg);
    add(image);

    // world boundaries
    Vector2 gameSize = screenToWorld(vec);
    addAll(Boundaries.createBoundaries(gameSize));

    // tiled map
    final tiledMap = await TiledComponent.load('emap.tmx', Vector2.all(16));
    add(tiledMap);

    // final objectGroup = tiledMap.tileMap.getObjectGroupFromLayer('ObjectLayer');
    // _things.addCollidables(objectGroup);
    // add(_things);

    Vector2 position = Vector2(vec.x / 5, vec.y / 2);
    final ball = Football(position, size: Vector2(25, 25));
    add(ball);

    position = Vector2(vec.x / 2, vec.y / 3);
    final ball2 = Football(position, size: Vector2(25, 25));
    add(ball2);

    // character
    String filePath = await fileStorage.storagePath("rive") + "character.riv";
    final artBoard = await loadArtboard(RiveFile.file(filePath));
    // final artBoard = await loadArtboard(RiveFile.network("http://www.aaronview.cn/design/res/character.riv"));
    RiveComponent riveComponent = RiveComponent(artboard: artBoard);
    final initPosition = Vector2(vec.x / 2, vec.y / 2);
    _character = Character(riveComponent, initPosition);
    add(_character);
    // camera follow the character
    camera.followComponent(_character.riveComponent, worldBounds: Rect.fromLTRB(0, 0, vec.x, vec.y));

    /// Particle Effect
    ParticleComponent pc = ParticleComponent(
      fp.TranslatedParticle(
        lifespan: 5,
        offset: Vector2(vec.x / 2, vec.y / 2.5),
        child: fireworkParticle(),
      ),
    );
    add(pc);
  }

  void onJoypadDirectionChanged(Direction direction) {
    _character.direction = direction;
  }

  @override
  KeyEventResult onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyW) && keysPressed.contains(LogicalKeyboardKey.keyD)) {
      _character.direction = Direction.upRight;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD) && keysPressed.contains(LogicalKeyboardKey.keyS)) {
      _character.direction = Direction.downRight;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS) && keysPressed.contains(LogicalKeyboardKey.keyA)) {
      _character.direction = Direction.downLeft;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA) && keysPressed.contains(LogicalKeyboardKey.keyW)) {
      _character.direction = Direction.upLeft;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyW)) {
      _character.direction = Direction.up;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      _character.direction = Direction.right;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyS)) {
      _character.direction = Direction.down;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      _character.direction = Direction.left;
    } else {
      _character.direction = Direction.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  fp.Particle fireworkParticle() {
    // A pallete to paint over the "sky"
    final paints = [
      Colors.amber,
      Colors.amberAccent,
      Colors.red,
      Colors.redAccent,
      Colors.yellow,
      Colors.yellowAccent,
      // Adds a nice "lense" tint
      // to overall effect
      Colors.blue,
    ].map((color) => Paint()..color = color).toList();

    return fp.Particle.generate(
      generator: (i) {
        final initialSpeed = randomCellVector2();
        final deceleration = initialSpeed * -1;
        final gravity = Vector2(0, 40);

        return fp.AcceleratedParticle(
          speed: initialSpeed,
          acceleration: deceleration + gravity,
          child: fp.ComputedParticle(
            renderer: (canvas, particle) {
              final paint = randomElement(paints);
              // Override the color to dynamically update opacity
              paint.color = paint.color.withOpacity(1 - particle.progress);

              canvas.drawCircle(
                Offset.zero,
                // Closer to the end of lifespan particles
                // will turn into larger glaring circles
                rnd.nextDouble() * particle.progress > .6
                    ? rnd.nextDouble() * (50 * particle.progress)
                    : 2 + (3 * particle.progress),
                paint,
              );
            },
          ),
        );
      },
    );
  }

  final Random rnd = Random();
  static const gridSize = 5.0;
  Vector2 get cellSize => size / gridSize;

  /// Returns random [Vector2] within a virtual grid cell
  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(cellSize);
  }

  /// Returns a random element from a given list
  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }
}