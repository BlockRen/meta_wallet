import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import './direction.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent with HasGameRef, HasHitboxes, Collidable {
  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.15;

  SpriteAnimation? _runDownAnimation;
  SpriteAnimation? _runLeftAnimation;
  SpriteAnimation? _runUpAnimation;
  SpriteAnimation? _runRightAnimation;
  SpriteAnimation? _standingAnimation;

  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Player() : super(size: Vector2.all(50.0)) {
    addHitbox(HitboxRectangle());
    collidableType = CollidableType.active;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    // if (other is ScreenCollidable) {
      if (!_hasCollided && _collisionDirection != direction) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    // } else {
    //
    // }

    // _isWallHit = true;
    // final firstPoint = intersectionPoints.first;
    // // If you don't move/zoom the camera this step can be skipped
    // final screenPoint = gameRef.projectVector(firstPoint);
    // final screenSize = gameRef.size;
    // if (screenPoint.x == 0) {
    //   // Left wall (or one of the leftmost corners)
    // } else if (screenPoint.y == 0) {
    //   // Top wall (or one of the upper corners)
    // } else if (screenPoint.x == screenSize.x) {
    //   // Right wall (or one of the rightmost corners)
    // } else if (screenPoint.y == screenSize.y) {
    //   // Bottom wall (or one of the bottom corners)
    // }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);
    _runLeftAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);
    _runUpAnimation = spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);
    _runRightAnimation = spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);
    _standingAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.upRight:
        animation = _runUpAnimation;
        moveUpRight(delta);
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.downRight:
        animation = _runDownAnimation;
        moveDownRight(delta);
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.downLeft:
        animation = _runDownAnimation;
        moveDownLeft(delta);
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.upLeft:
        animation = _runUpAnimation;
        moveUpLeft(delta);
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveUpRight(double delta) {
    position.add(Vector2(delta * _playerSpeed / 2, delta * -_playerSpeed / 2));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  void moveDownRight(double delta) {
    position.add(Vector2(delta * _playerSpeed / 2, delta * _playerSpeed / 2));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveDownLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed / 2, delta * _playerSpeed / 2));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveUpLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed / 2, delta * -_playerSpeed / 2));
  }
}
