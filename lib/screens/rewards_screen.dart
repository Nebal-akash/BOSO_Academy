import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RewardsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> badges = [
    {"title": "AI Beginner", "icon": FontAwesomeIcons.robot, "color": Colors.blue, "unlocked": true},
    {"title": "Quiz Master", "icon": FontAwesomeIcons.brain, "color": Colors.purple, "unlocked": true},
    {"title": "Streak King", "icon": FontAwesomeIcons.fire, "color": Colors.black87, "unlocked": false},
    {"title": "AI Guru", "icon": FontAwesomeIcons.award, "color": Colors.green, "unlocked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Achievements", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white12,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎯 XP & Streak Section
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                leading: Icon(FontAwesomeIcons.star, color: Colors.amber, size: 40),
                title: Text("Total XP: 1250", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                subtitle: Text("Current Streak: 7 days 🔥"),
              ),
            ),
            SizedBox(height: 20),

            // 🏅 Achievements
            Text("Your Badges", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: badges.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: badges[index]["unlocked"] ? badges[index]["color"].withOpacity(0.2) : Colors.orange[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(badges[index]["icon"], size: 40, color: badges[index]["unlocked"] ? badges[index]["color"] : Colors.yellow),
                        SizedBox(height: 10),
                        Text(
                          badges[index]["title"],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
