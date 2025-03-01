import 'package:flame/components.dart';

class Enemy extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load("images/enemy.png");
    position = Vector2(300, 100);
    size = Vector2(64, 64);
  }
}
