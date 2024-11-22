import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'dino_game.dart';

class ScoreDisplay extends TextComponent with HasGameRef<DinoGame> {
  ScoreDisplay(this.gameRef);

  final DinoGame gameRef;

  @override
  Future<void> onLoad() async {
    anchor = Anchor.topRight;
    position = Vector2(gameRef.size.x - 50, 10);
    textRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 32.0,
        color: Colors.white,
      ),
    );
    text = 'Pontuação: ${gameRef.score}';
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Pontuação: ${gameRef.score}';
  }
}