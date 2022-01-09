
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/forge2d_game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:forge2d/src/dynamics/body.dart';
import 'package:rive/rive.dart';

class RiveBodyComponent<T extends Forge2DGame>
    extends BodyComponent<T> {

  RiveComponent? riveComponent; // instead of the positionComponent

  RiveBodyComponent() : super(
    // artboard: artboard,
    // size: Vector2.all(80),
  );

  @override
  Body createBody() {
    // TODO: implement createBody
    throw UnimplementedError();
  }

}