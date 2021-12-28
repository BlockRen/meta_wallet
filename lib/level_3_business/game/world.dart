import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:meta_wallet/level_3_business/game/flame_tiled.dart';

class World extends PositionComponent with HasGameRef, HasHitboxes, Collidable {
  World() {
    final shape = HitboxPolygon([
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(-1, 0),
    ]);
    addHitbox(shape);
    collidableType = CollidableType.passive;
  }
}