import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'ai_rpg_game.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: AIRPGGame(),
      ),
    );
  }
}
