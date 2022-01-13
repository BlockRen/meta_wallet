import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_forge2d/position_body_component.dart';
import 'package:tiled/tiled.dart';

class CollidablePolygon extends PositionComponent with HasHitboxes, Collidable {
  @override
  CollidableType collidableType = CollidableType.passive;

  List<Vector2> normalizedList = [];

  CollidablePolygon(TiledObject object) {
    double minX = 0;
    double maxX = 0;
    double minY = 0;
    double maxY = 0;
    for (final point in object.polygon) {
      minX = point.x < minX ? point.x : minX;
      maxX = point.x > maxX ? point.x : maxX;
      minY = point.y < minY ? point.y : minY;
      maxY = point.y > maxY ? point.y : maxY;
    }

    size = Vector2((maxX - minX) / 2, (maxY - minY) / 2);
    if (size.x == 0 || size.y == 0) {
      return;
    }
    Vector2 centerOffset = Vector2((maxX + minX) / 2, (maxY + minY) / 2);
    position = Vector2((object.x + minX) / 2, (object.y + minY) / 2);
    normalizedList = object.polygon.map((point) => Vector2((point.x - centerOffset.x) / size.x, (point.y - centerOffset.y) / size.y)).toList();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final hitBox = HitboxPolygon(normalizedList);
    addHitbox(hitBox);
  }
}

class Football extends PositionBodyComponent {
  final Vector2 position;

  Football(
    this.position, {
      Vector2? size,
  }) : super(size: size ?? Vector2(3, 3));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = await gameRef.loadSprite('soccer.png');
    positionComponent = SpriteComponent(sprite: sprite, size: size);
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(2, 2);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.2
      ..density = 1.0
      ..friction = 0.4;
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = position;
    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }
}