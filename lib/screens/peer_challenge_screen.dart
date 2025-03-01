import 'package:flutter/material.dart';

class PeerChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Peer Challenge"), backgroundColor: Colors.deepPurpleAccent),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Later, integrate Firebase for real-time challenges
          },
          child: Text("Start Peer Challenge"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
        ),
      ),
    );
  }
}
