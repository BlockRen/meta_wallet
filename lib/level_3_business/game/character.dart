import 'package:flame/components.dart';
import 'package:flame_forge2d/contact_callbacks.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';
import 'package:meta_wallet/level_3_business/game/direction.dart';
import 'package:meta_wallet/level_3_business/game/sprite/rive_body_component.dart';

class Character extends RiveBodyComponent with ContactCallback {
  final Vector2 position;

  Character(RiveComponent riveComponent, this.position, {
    Vector2? size
  }) : super(
    riveComponent,
    size ?? Vector2.all(150)
  );

  SMIInput<double>? _levelInput;
  final double _moveSpeed = 50.0;
  Direction direction = Direction.none;

  @override
  Future<void> onLoad() async {
    final controller = StateMachineController.fromArtboard(riveComponent.artboard, "WalkMachine");
    if (controller != null) {
      riveComponent.artboard.addController(controller);
      _levelInput = controller.findInput<double>('direction');
      _levelInput?.value = 0;
    }
    return super.onLoad();
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(15, 15);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.2
      ..density = 5.0
      ..friction = 0.95;
    final bodyDef = BodyDef()
      // To be able to determine object in collision
      ..userData = this
      ..type = BodyType.dynamic
      ..fixedRotation = true
      ..linearDamping = 5.0
      /// the origin of coordinates of forge2d is the top-left point of screen, but the flame's is
      /// bottom-left, so the y-value must be the opposite.
      ..position = Vector2(position.x, -position.y);
    final body = world.createBody(bodyDef)..createFixture(fixtureDef);
    return body;
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void movePlayer(double delta) {
    // debugPrint("the move delta: " + delta.toString());
    /// why 0.7
    /// To ensure the 45 degree move to be the same speed with the row. So sqrt(1) is about 0.7
    switch (direction) {
      case Direction.up:
        _levelInput?.value = 0;
        body.linearVelocity = Vector2(0, 1 * _moveSpeed);
        break;
      case Direction.upRight:
        _levelInput?.value = 1;
        body.linearVelocity = Vector2(0.7 * _moveSpeed, 0.7 * _moveSpeed);
        break;
      case Direction.right:
        _levelInput?.value = 2;
        body.linearVelocity = Vector2(1 * _moveSpeed, 0);
        break;
      case Direction.downRight:
        _levelInput?.value = 3;
        body.linearVelocity = Vector2(0.7 * _moveSpeed, -0.7 * _moveSpeed);
        break;
      case Direction.down:
        _levelInput?.value = 4;
        body.linearVelocity = Vector2(0, -1 * _moveSpeed);
        break;
      case Direction.downLeft:
        _levelInput?.value = 5;
        body.linearVelocity = Vector2(-0.7 * _moveSpeed, -0.7 * _moveSpeed);
        break;
      case Direction.left:
        _levelInput?.value = 6;
        body.linearVelocity = Vector2(-1 * _moveSpeed, 0);
        break;
      case Direction.upLeft:
        _levelInput?.value = 7;
        body.linearVelocity = Vector2(-0.7 * _moveSpeed, 0.7 * _moveSpeed);
        break;
      case Direction.none:
        _levelInput?.value = 0;
        break;
    }
  }

  /// Contact callback
  @override
  void begin(a, b, Contact contact) {

  }

  @override
  void end(a, b, Contact contact) {

  }
}