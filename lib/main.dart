import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game/dino_game.dart';

void main() {
  runApp(GameWidget<DinoGame>(
    game: DinoGame(),
    overlayBuilderMap: {
      'GameOver': (BuildContext context, DinoGame gameRef) {
        return GameOverOverlay(gameRef: gameRef, score: gameRef.score);
      },
    },
  ));
}
class GameOverOverlay extends StatelessWidget {
  final DinoGame gameRef;
  final int score;

  GameOverOverlay({required this.gameRef, required this.score});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Game Over',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pontuação: $score',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => gameRef.restartGame(),
                    child: Text('Restart'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}