import 'package:flame/components.dart';

class Player extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load("images/player.png");
    position = Vector2(100, 100);
    size = Vector2(64, 64);
  }

  void move(Vector2 delta) {
    position += delta;
  }
}
