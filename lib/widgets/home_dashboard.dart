import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Welcome Section
          Text(
            "Welcome Back, John! 👋",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            "Let's continue learning and achieve your goals today!",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 20),

          // 🔹 Quick Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(Icons.play_arrow, "Continue Learning"),
              _buildActionButton(Icons.quiz, "Start Quiz"),
              _buildActionButton(Icons.analytics, "Check Progress"),
            ],
          ),
          SizedBox(height: 20),

          // 🔹 Progress Overview
          Text("Your Learning Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          LinearPercentIndicator(
            lineHeight: 10.0,
            percent: 0.65, // ✅ Set dynamically later
            backgroundColor: Colors.grey[800],
            progressColor: Colors.deepPurpleAccent,
            barRadius: Radius.circular(10),
          ),
          SizedBox(height: 20),

          // 🔹 Recent Activities
          Text("Recent Activities", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          _buildActivityTile("Completed: AI Basics", "Feb 11, 2025"),
          _buildActivityTile("Started: Machine Learning 101", "Feb 10, 2025"),
          _buildActivityTile("Quiz: Neural Networks", "Feb 9, 2025"),
        ],
      ),
    );
  }

  // 🔹 Quick Action Button
  Widget _buildActionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // 🔹 Recent Activity Tile
  Widget _buildActivityTile(String title, String date) {
    return ListTile(
      leading: Icon(Icons.check_circle, color: Colors.deepPurpleAccent),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: Text(date, style: TextStyle(color: Colors.white70)),
    );
  }
}
