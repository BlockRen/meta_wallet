import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:forge2d/forge2d.dart';

///
abstract class RiveBodyComponent<T extends Forge2DGame>
    extends BodyComponent<T> {
  final RiveComponent riveComponent;
  final Vector2 size;

  RiveBodyComponent(this.riveComponent, this.size);

  @mustCallSuper
  @override
  Future<void> onMount() async {
    super.onMount();
    riveComponent.anchor = Anchor.center;
    riveComponent.size = size;
    if (!gameRef.contains(riveComponent)) {
      gameRef.add(riveComponent);
    }
    _updatePositionComponent();
  }

  @override
  void update(double dt) {
    _updatePositionComponent();
  }

  @override
  void onRemove() {
    // Since the RiveComponent was added to the game in this class it should
    // also be removed by this class when the BodyComponent is removed.
    riveComponent.removeFromParent();
    super.onRemove();
  }

  void _updatePositionComponent() {
    final bodyPosition = body.position;
    riveComponent.position.setValues(bodyPosition.x, bodyPosition.y * -1);
    riveComponent.angle = -angle;
  }
}