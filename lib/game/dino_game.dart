import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/foundation.dart';
import 'dino.dart';
import 'obstacle.dart';
import 'score_display.dart';

class DinoGame extends FlameGame with HasCollisionDetection, TapCallbacks {
  late Dino dino;
  late TimerComponent spawnTimer;
  int score = 0;
  bool gameOver = false;
  double obstacleSpeed = 500; //velocidade começo

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // background
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    ));

    // chao
    add(RectangleComponent(
      position: Vector2(0, size.y - 100),
      size: Vector2(size.x, 100),
      paint: Paint()..color = Colors.green,
    ));

    // dino aparece
    dino = Dino();
    add(dino);

    // timer dos obstaculos
    spawnTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () {
        if (!gameOver) {  
          add(Obstacle(obstacleSpeed));
        }
      },
    );
    add(spawnTimer);

    // pontuacao
    add(ScoreDisplay(this));

    // colisao na tela
    add(ScreenHitbox());
  }

  @override
  void onTapDown(TapDownEvent info) {
    super.onTapDown(info);
    if (!gameOver) {
      dino.jump();
    }
  }

  void increaseScore() {
    score++;
    if (score % 3 == 0) {
      obstacleSpeed *= 1.3;
    }
  }

  void showGameOver() {
    if (!gameOver) {
      gameOver = true;
      overlays.add('GameOver');
      pauseEngine();
    }
  }

  void restartGame() {
    debugPrint('Restarting game');
    removeAll(children);
    score = 0;
    gameOver = false;
    obstacleSpeed = 500; 

    add(RectangleComponent(size: size, paint: Paint()..color = Colors.blue));
    // Ground
    add(RectangleComponent(position: Vector2(0, size.y - 100), size: Vector2(size.x, 100), paint: Paint()..color = Colors.green));
    
    // New Dino instance
    dino = Dino();
    add(dino);
    debugPrint('Dino added in restartGame');

    // Timer for spawning obstacles
    spawnTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () {
        if (!gameOver) {  
          add(Obstacle(obstacleSpeed));
        }
      },
    );
    add(spawnTimer);

    // Score display
    add(ScoreDisplay(this));
    // Screen collision
    add(ScreenHitbox());

    resumeEngine(); // Make sure the game engine is running
    overlays.remove('GameOver');
  }
}