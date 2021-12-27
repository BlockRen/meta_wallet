import 'dart:collection';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import './direction.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef {
  final double _playerSpeed = 50.0;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction direction = Direction.none;
  final Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  Player() : super(size: Vector2.all(50.0)) {
    addHitbox(HitboxRectangle());
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

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   super.onCollision(intersectionPoints, other);
  //
  //   // if (other is WorldCollidable) {
  //   //   if (!_hasCollided) {
  //   //     _hasCollided = true;
  //   //     _collisionDirection = direction;
  //   //   }
  //   // }
  // }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
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

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }

  @override
  void addHitbox(HitboxShape shape) {
    // TODO: implement addHitbox
  }

  // @override
  // // TODO: implement hitboxes
  // UnmodifiableListView<HitboxShape> get hitboxes => throw UnimplementedError();
  //
  // @override
  // bool possiblyContainsPoint(Vector2 point) {
  //   // TODO: implement possiblyContainsPoint
  //   throw UnimplementedError();
  // }
  //
  // @override
  // bool possiblyOverlapping(HasHitboxes other) {
  //   // TODO: implement possiblyOverlapping
  //   throw UnimplementedError();
  // }
  //
  // @override
  // void removeHitbox(HitboxShape shape) {
  //   // TODO: implement removeHitbox
  // }
  //
  // @override
  // void renderHitboxes(Canvas canvas, {Paint? paint}) {
  //   // TODO: implement renderHitboxes
  // }
}
