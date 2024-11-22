import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'dino_game.dart';

class Obstacle extends RectangleComponent with HasGameRef, CollisionCallbacks {
  final double speed;

  Obstacle(this.speed)
      : super(
          size: Vector2(22, 100),
          anchor: Anchor.center,
          paint: Paint()..color = Colors.red,
        );

  @override
  Future<void> onLoad() async {
    position = Vector2(gameRef.size.x, gameRef.size.y - 80);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    x -= speed * dt;

    if (x + width < 0) {
      (gameRef as DinoGame).increaseScore();
      removeFromParent();
    }
  }
}