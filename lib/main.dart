import 'package:flutter/material.dart';

void main() {
  runApp(const GamingApp());
}

class GamingApp extends StatelessWidget {
  const GamingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gaming Zone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        primaryColor: Colors.redAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B2F),
          elevation: 0,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const TournamentScreen(),
    const UploadScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1B1B2F),
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Custom Room'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 35), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// 1. Home Feed Screen
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔥 GAMING FEED', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF1B1B2F),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.sports_esports, color: Colors.white),
                  ),
                  title: Text('Gamer_${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Free Fire • Just now', style: TextStyle(color: Colors.grey)),
                ),
                Container(
                  height: 200,
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(Icons.play_circle_fill, size: 60, color: Colors.redAccent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(icon: const Icon(Icons.favorite_border, color: Colors.redAccent), onPressed: () {}),
                      const Text('120'),
                      const SizedBox(width: 15),
                      IconButton(icon: const Icon(Icons.comment_outlined), onPressed: () {}),
                      const Text('45'),
                      const Spacer(),
                      IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 2. Custom Tournament & Room Screen
class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CUSTOM TOURNAMENTS')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildRoomCard("Grand Daily Scrims", "Free Fire", "Room ID: 948210", "Pass: 1234", "Starts: 8:00 PM"),
          _buildRoomCard("1v1 Headshot Challenge", "Free Fire", "Room ID: 110294", "Pass: 0000", "Starts: 9:30 PM"),
        ],
      ),
    );
  }

  Widget _buildRoomCard(String title, String game, String roomId, String pass, String time) {
    return Card(
      color: const Color(0xFF1B1B2F),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 6),
            Text('Game: $game | $time', style: const TextStyle(color: Colors.grey)),
            const Divider(color: Colors.white24, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(roomId, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(pass, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  onPressed: () {},
                  child: const Text('Join Room'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Upload Post/Video Screen
class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CREATE POST / CLIP')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1B1B2F),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.video_library, size: 50, color: Colors.redAccent),
                  SizedBox(height: 8),
                  Text('Select Gameplay Video or Screenshot', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Add Caption or #Tags (e.g. #Headshot, #Clutch)',
                filled: true,
                fillColor: const Color(0xFF1B1B2F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {},
                child: const Text('POST CLIP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Gamer Profile Screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GAMER PROFILE')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Z-GOD GAMER', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('UID: 204918204 | Rank: Grandmaster', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Posts', '14'),
                _buildStat('Followers', '1.2K'),
                _buildStat('Matches', '120'),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String count) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
