import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:meta_wallet/level_3_business/game/flame_tiled.dart';
import 'package:tiled/tiled.dart' show ObjectGroup, TiledObject;

class TiledGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final tiledMap = await TiledComponent.load('mymap.tmx', Vector2.all(16));
    add(tiledMap);
  }
}