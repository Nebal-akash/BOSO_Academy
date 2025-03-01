import 'package:flutter/material.dart';
import '../game/game_screen.dart';

class GameMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("AI RPG Game"), backgroundColor: Colors.deepPurpleAccent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Start Game"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
              },
            ),
            ElevatedButton(
              child: Text("Exit"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
