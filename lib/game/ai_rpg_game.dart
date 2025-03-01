import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'player.dart';
import 'enemy.dart';

class AIRPGGame extends FlameGame {
  late Player player;
  late Enemy enemy;

  @override
  Future<void> onLoad() async {
    player = Player();
    enemy = Enemy();

    add(player);
    add(enemy);
  }
}
