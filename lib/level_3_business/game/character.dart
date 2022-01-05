import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:rive/rive.dart';
import 'package:flame_rive/flame_rive.dart';
import 'direction.dart';

class CharacterComponent extends RiveComponent with HasGameRef, HasHitboxes, Collidable {
  CharacterComponent(Artboard artboard) : super(
    artboard: artboard,
    size: Vector2.all(80),
  ) {
    addHitbox(HitboxRectangle());
    collidableType = CollidableType.active;
  }

  SMIInput<int>? _levelInput;
  final double _playerSpeed = 100.0;
  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Vector2 _prePosition = Vector2.zero();

  @override
  Future<void>? onLoad() async {
    final controller = StateMachineController.fromArtboard(artboard, "WalkMachine");
    if (controller != null) {
      artboard.addController(controller);
      _levelInput = controller.findInput<int>('direction');
      _levelInput?.value = 0;
    }
    return super.onLoad();
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    _hasCollided = true;

    _prePosition = position;

    if (_collisionDirection == Direction.none) {
      _collisionDirection = direction;
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
    _collisionDirection = Direction.none;
  }

  void movePlayer(double delta) {
    if (!canPlayerMove()) {
      position = _prePosition;
      return;
    }
    switch (direction) {
      case Direction.up:
        _levelInput?.value = 0;
        moveUp(delta);
        break;
      case Direction.upRight:
        _levelInput?.value = 1;
        moveUpRight(delta);
        break;
      case Direction.right:
        _levelInput?.value = 2;
        moveRight(delta);
        break;
      case Direction.downRight:
        _levelInput?.value = 3;
        moveDownRight(delta);
        break;
      case Direction.down:
        _levelInput?.value = 4;
        moveDown(delta);
        break;
      case Direction.downLeft:
        _levelInput?.value = 5;
        moveDownLeft(delta);
        break;
      case Direction.left:
        _levelInput?.value = 6;
        moveLeft(delta);
        break;
      case Direction.upLeft:
        _levelInput?.value = 7;
        moveUpLeft(delta);
        break;
      case Direction.none:
        _levelInput?.value = 0;
        break;
    }
  }

  bool canPlayerMove() {
    if (_hasCollided && nearDirection(direction)) {
      return false;
    }
    return true;
  }

  bool nearDirection(Direction dir) {
    switch (_collisionDirection) {
      case Direction.up:
        return (dir==Direction.left || dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight || dir==Direction.right);
      case Direction.upRight:
        return (dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight);
      case Direction.right:
        return (dir==Direction.up || dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight || dir==Direction.down);
      case Direction.downRight:
        return (dir==Direction.upRight || dir==Direction.right || dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft);
      case Direction.down:
        return (dir==Direction.right || dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft || dir==Direction.left);
      case Direction.downLeft:
        return (dir==Direction.downRight || dir==Direction.down || dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft);
      case Direction.left:
        return (dir==Direction.down || dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft || dir==Direction.up);
      case Direction.upLeft:
        return (dir==Direction.downLeft || dir==Direction.left || dir==Direction.upLeft || dir==Direction.up || dir==Direction.upRight);
      case Direction.none:
        break;
    }
    return false;
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveUpRight(double delta) {
    position.add(Vector2(delta * _playerSpeed / 1.8, delta * -_playerSpeed / 1.8));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  void moveDownRight(double delta) {
    position.add(Vector2(delta * _playerSpeed / 1.8, delta * _playerSpeed / 1.8));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveDownLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed / 1.8, delta * _playerSpeed / 1.8));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveUpLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed / 1.8, delta * -_playerSpeed / 1.8));
  }
}