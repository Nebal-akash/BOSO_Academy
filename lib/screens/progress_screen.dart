import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressScreen extends StatelessWidget {
  final int userXP = 1250; // Example XP (You can fetch this dynamically)

  // 🎖 New Rank System with 7 Ranks
  final List<Map<String, dynamic>> ranks = [
    {"name": "Bronze", "xp": 0, "image": "lib/assets/ranks/bronze.png"},
    {"name": "Silver", "xp": 1000, "image": "lib/assets/ranks/silver.png"},
    {"name": "Gold", "xp": 2500, "image": "lib/assets/ranks/gold.png"},
    {"name": "Platinum", "xp": 4000, "image": "lib/assets/ranks/platinum.png"},
    {"name": "Diamond", "xp": 6000, "image": "lib/assets/ranks/diamond.png"},
    {"name": "Emerald", "xp": 8000, "image": "lib/assets/ranks/emerald.png"},
    {"name": "Ruby", "xp": 10000, "image": "lib/assets/ranks/ruby.png"},
  ];

  @override
  Widget build(BuildContext context) {
    // 🎯 Find current & next rank
    Map<String, dynamic> currentRank = ranks[0];
    Map<String, dynamic>? nextRank;

    for (int i = 0; i < ranks.length; i++) {
      if (userXP >= ranks[i]["xp"]) {
        currentRank = ranks[i];
        if (i + 1 < ranks.length) nextRank = ranks[i + 1];
      }
    }

    // 🎯 XP progress towards next rank
    double progress = nextRank != null
        ? (userXP - currentRank["xp"]) / (nextRank["xp"] - currentRank["xp"])
        : 1.0;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Progress", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 1,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🎖 XP and Rank Card
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
              child: ListTile(
                leading: GestureDetector(
                  onTap: () => _showRanks(context), // 🔹 Show all ranks on tap
                  child: SizedBox(
                    width: 150, // 🔹 Increased width
                    height: 150, // 🔹 Increased height
                    child: Image.asset(currentRank["image"], fit: BoxFit.contain),
                  ),
                ),
                title: Text(
                  "XP Points: $userXP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text("Current Rank: ${currentRank["name"]}"),
              ),
            ),
            SizedBox(height: 10),

            // 🎯 Progress Bar to Next Rank
            if (nextRank != null) ...[
              Text("Next Rank: ${nextRank["name"]}", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              LinearPercentIndicator(
                lineHeight: 8,
                percent: progress,
                progressColor: Colors.deepPurpleAccent,
                backgroundColor: Colors.grey[300],
                barRadius: Radius.circular(5),
                animation: true,
                animationDuration: 800,
              ),
              SizedBox(height: 20),
            ],

            // 📊 Course Progress
            Text("Course Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(child: _buildCourseProgress()),
          ],
        ),
      ),
    );
  }

  // 📊 Course Progress UI
  Widget _buildCourseProgress() {
    final List<Map<String, dynamic>> progressData = [
      {"subject": "AI Basics", "progress": 0.8, "color": Colors.blue},
      {"subject": "Machine Learning", "progress": 0.6, "color": Colors.purple},
      {"subject": "Deep Learning", "progress": 0.4, "color": Colors.orange},
      {"subject": "Data Science", "progress": 0.7, "color": Colors.green},
    ];

    return ListView.builder(
      itemCount: progressData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(progressData[index]["subject"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  LinearPercentIndicator(
                    lineHeight: 8,
                    percent: progressData[index]["progress"],
                    progressColor: progressData[index]["color"],
                    backgroundColor: Colors.grey[300],
                    barRadius: Radius.circular(5),
                    animation: true,
                    animationDuration: 800,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 🎖 Show All Ranks in a Modal
  void _showRanks(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Rank System"),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: ranks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  width: 120, // 🔹 Increased width
                  height: 120, // 🔹 Increased height
                  child: Image.asset(ranks[index]["image"], fit: BoxFit.contain),
                ),
                title: Text(ranks[index]["name"]),
                subtitle: Text("XP Required: ${ranks[index]["xp"]}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
