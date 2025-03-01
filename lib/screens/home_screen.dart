import 'package:flutter/material.dart';
import '../screens/learn_screen.dart';
import '../screens/practice_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/rewards_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/calendar_screen.dart';
import '../screens/pdf_learning_screen.dart';
import '../screens/ai_tutor_screen.dart';
import '../screens/game_main_menu.dart';
import '../widgets/home_dashboard.dart';
import '../screens/NewsFeedScreen.dart';
import '../screens/youtube_learning_screen.dart';
import '../screens/coursera_courses_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeDashboard(),
    LearnScreen(),
    PracticeScreen(),
    ProgressScreen(),
    RewardsScreen(),
    CalendarScreen(),
    PDFLearningScreen(),
    YouTubeLearningScreen(), // Corrected this line
    GameMainMenu(),
    Newsfeed(),
    CourseraCoursesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 260,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple.shade800, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    // Profile Section
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/images/Boso.png'),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello, John!",
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                              Text("AI Enthusiast", style: TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white24),

                    // Sidebar Items
                    _buildSidebarItem(Icons.dashboard, "Home", 0),
                    _buildSidebarItem(Icons.school, "Learn", 1),
                    _buildSidebarItem(Icons.quiz, "Practice", 2),
                    _buildSidebarItem(Icons.bar_chart, "Progress", 3),
                    _buildSidebarItem(Icons.emoji_events, "Rewards", 4),
                    _buildSidebarItem(Icons.calendar_today, "Calendar", 5),
                    _buildSidebarItem(Icons.picture_as_pdf, "PDF Learning", 6),
                    _buildSidebarItem(Icons.video_library, "YouTube Learning", 7),
                    _buildSidebarItem(Icons.sports_esports, "Game", 8),
                    _buildSidebarItem(Icons.book, "Newsfeed", 9),
                    _buildSidebarItem(Icons.account_balance,"Courses", 10),
                    Spacer(),
                    _buildSidebarItem(Icons.settings, "Settings", -1),
                    SizedBox(height: 20),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: _selectedIndex >= 0 ? _screens[_selectedIndex] : Container(),
                ),
              ),
            ],
          ),

          // AI Tutor Floating Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.chat, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AITutorScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return Tooltip(
      message: title, // Tooltip text
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.deepPurpleAccent : Colors.white70),
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
        selected: isSelected,
        selectedTileColor: Colors.deepPurpleAccent.withOpacity(0.3),
        hoverColor: Colors.deepPurple.withOpacity(0.2),
        onTap: () {
          if (index == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen())).then((_) {
              setState(() => _selectedIndex = 0);
            });
          } else {
            setState(() => _selectedIndex = index);
          }
        },
      ),
    );
  }
}