import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';
import 'package:meta_wallet/level_3_business/game/direction.dart';
import 'package:meta_wallet/level_3_business/game/sprite/rive_body_component.dart';

class Character extends RiveBodyComponent {
  final Vector2 position;

  Character(RiveComponent riveComponent, this.position, {
    Vector2? size
  }) : super(
    riveComponent,
    size ?? Vector2.all(150)
  );

  SMIInput<double>? _levelInput;
  final double _moveSpeed = 15.0;
  Direction direction = Direction.none;
  // Direction _collisionDirection = Direction.none;
  // bool _hasCollided = false;
  //
  // Vector2 _prePosition = Vector2.zero();

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
    final shape = PolygonShape()..setAsBoxXY(50, 60);
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.2
      ..density = 1.0
      ..friction = 0.4;
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
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
    // if (!canPlayerMove()) {
    //   position = _prePosition;
    //   return;
    // }
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

  // bool canPlayerMove() {
  //   if (_hasCollided && nearDirection(direction)) {
  //     return false;
  //   }
  //   return true;
  // }

  // bool nearDirection(Direction dir) {
  //   switch (_collisionDirection) {
  //     case Direction.up:
  //       return (dir==Direction.left || dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight || dir==Direction.right);
  //     case Direction.upRight:
  //       return (dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight);
  //     case Direction.right:
  //       return (dir==Direction.up || dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight || dir==Direction.down);
  //     case Direction.downRight:
  //       return (dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft);
  //     case Direction.down:
  //       return (dir==Direction.right || dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft || dir==Direction.left);
  //     case Direction.downLeft:
  //       return (dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft);
  //     case Direction.left:
  //       return (dir==Direction.down || dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft || dir==Direction.up);
  //     case Direction.upLeft:
  //       return (dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight);
  //     case Direction.none:
  //       break;
  //   }
  //   return false;
  // }

  // void moveUp(double delta) {
  //   position.add(Vector2(0, delta * -_playerSpeed));
  // }
  //
  // void moveUpRight(double delta) {
  //   position.add(Vector2(delta * _playerSpeed / 1.8, delta * -_playerSpeed / 1.8));
  // }
  //
  // void moveRight(double delta) {
  //   position.add(Vector2(delta * _playerSpeed, 0));
  // }
  //
  // void moveDownRight(double delta) {
  //   position.add(Vector2(delta * _playerSpeed / 1.8, delta * _playerSpeed / 1.8));
  // }
  //
  // void moveDown(double delta) {
  //   position.add(Vector2(0, delta * _playerSpeed));
  // }
  //
  // void moveDownLeft(double delta) {
  //   position.add(Vector2(delta * -_playerSpeed / 1.8, delta * _playerSpeed / 1.8));
  // }
  //
  // void moveLeft(double delta) {
  //   position.add(Vector2(delta * -_playerSpeed, 0));
  // }
  //
  // void moveUpLeft(double delta) {
  //   position.add(Vector2(delta * -_playerSpeed / 1.8, delta * -_playerSpeed / 1.8));
  // }
}