import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white10,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // ⬅️ Fix: Ensure it's visible
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // ✅ Ensures it only pops if there's a previous screen
            }
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // 👤 Profile Section
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            title: Text("John Doe", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("johndoe@example.com"),
            trailing: Icon(Icons.edit, color: Colors.grey),
            onTap: () {
              // TODO: Navigate to profile edit screen
            },
          ),
          Divider(),

          // 🌙 Dark Mode Toggle
          SwitchListTile(
            title: Text("Dark Mode"),
            secondary: Icon(Icons.dark_mode),
            value: false, // TODO: Get dark mode status
            onChanged: (bool value) {
              // TODO: Implement dark mode switch
            },
          ),
          Divider(),

          // 🔔 Notifications
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            subtitle: Text("Manage push notifications"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // TODO: Navigate to notification settings
            },
          ),
          Divider(),

          // 🌍 Language Selection
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("English"),
            trailing: Icon(Icons.arrow_forward_ios, size: 18),
            onTap: () {
              // TODO: Show language selection modal
            },
          ),
          Divider(),

          // 🔓 Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Implement logout function
            },
          ),
        ],
      ),
    );
  }
}
