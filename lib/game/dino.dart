import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dino_game.dart';
import 'obstacle.dart';

class Dino extends PositionComponent with CollisionCallbacks, HasGameRef<DinoGame>, TapCallbacks {
  bool isJumping = false;
  double jumpSpeed = 0;
  double gravity = 980;

  Dino() {
    debugPrint('Dino initialized');
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(50, 50);
    anchor = Anchor.center;
    position = Vector2(50, gameRef.size.y - size.y / 2 - 100); // Position on ground

    // dino de fato
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.orange,
    ));

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (kDebugMode) {
      debugPrint('Dino update, isJumping: $isJumping, position.y: ${position.y}, speed: $jumpSpeed');
    }

    if (isJumping) {
      position.y += jumpSpeed * dt;
      jumpSpeed += gravity * dt;

      if (position.y >= gameRef.size.y - 100 - size.y / 2) {
        position.y = gameRef.size.y - 100 - size.y / 2;
        isJumping = false;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Obstacle) {
      gameRef.showGameOver();
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    isJumping = false;
    jumpSpeed = 0;
  }

  @override
  void onTapDown(TapDownEvent info) {
    super.onTapDown(info);
    if (kDebugMode) {
      debugPrint('Dino tapped!');
    }
    if (!gameRef.gameOver) {
      jump();
    }
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      jumpSpeed = -450; // Initial jump speed
      if (kDebugMode) {
        debugPrint('Dino is jumping');
      }
    }
  }
}