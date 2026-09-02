import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool isFirebaseReady = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    isFirebaseReady = true;
  } catch (e) {
    debugPrint("Firebase init deferred: $e");
  }
  runApp(const ZGodApp());
}

class ZGodApp extends StatelessWidget {
  const ZGodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-GOD GAMING',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D1A),
        primaryColor: const Color(0xFFFF0055),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF0055),
          secondary: Color(0xFF00E5FF),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  void _proceedToApp(String name) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(userName: name),
      ),
    );
  }

  Future<void> _handleGuestLogin() async {
    setState(() => _loading = true);
    if (isFirebaseReady) {
      try {
        await FirebaseAuth.instance.signInAnonymously();
      } catch (e) {
        debugPrint("Auth notice: $e");
      }
    }
    if (mounted) {
      setState(() => _loading = false);
      _proceedToApp('Guest Gamer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFF0055), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF0055).withOpacity(0.4),
                        blurRadius: 30,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.sports_esports, size: 68, color: Color(0xFFFF0055)),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Z-GOD GAMING',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Esports Hub & Custom Rooms',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 48),
                if (_loading)
                  const CircularProgressIndicator(color: Color(0xFFFF0055))
                else ...[
                  ElevatedButton.icon(
                    onPressed: _handleGuestLogin,
                    icon: const Icon(Icons.flash_on, color: Colors.white),
                    label: const Text(
                      'PLAY AS GUEST',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0055),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => _proceedToApp('Google Member'),
                    icon: const Icon(Icons.account_circle, size: 24, color: Color(0xFF00E5FF)),
                    label: const Text(
                      'SIGN IN WITH GOOGLE',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00E5FF), width: 1.5),
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  final String userName;
  const MainNavigationScreen({super.key, required this.userName});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FeedScreen(),
      const CustomRoomScreen(),
      ProfileScreen(userName: widget.userName),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF141424),
        selectedItemColor: const Color(0xFFFF0055),
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dynamic_feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _likes = 154;
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Z-GOD FEED', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF141424),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: const Color(0xFF16162A),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Color(0xFFFF0055),
                        child: Text('Z', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 12),
                      Text('Z-GOD Official', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Welcome to Z-GOD Gaming Hub! Create custom rooms, connect with squads, and dominate tournaments.',
                    style: TextStyle(color: Colors.white70, height: 1.4, fontSize: 15),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? const Color(0xFFFF0055) : Colors.white60,
                        ),
                        onPressed: () {
                          setState(() {
                            _isLiked = !_isLiked;
                            _likes += _isLiked ? 1 : -1;
                          });
                        },
                      ),
                      Text('$_likes likes', style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomRoomScreen extends StatefulWidget {
  const CustomRoomScreen({super.key});

  @override
  State<CustomRoomScreen> createState() => _CustomRoomScreenState();
}

class _CustomRoomScreenState extends State<CustomRoomScreen> {
  final List<Map<String, String>> _localRooms = [
    {'title': '4v4 Rush Match', 'id': '8849102', 'pass': '1234'},
    {'title': 'Bermuda Clash Tournament', 'id': '9920145', 'pass': '0000'},
  ];

  void _showCreateRoomSheet() {
    final titleController = TextEditingController();
    final idController = TextEditingController();
    final passController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF16162A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create Custom Room',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Room Title (e.g. 4v4 Rush)'),
            ),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Room ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF0055)),
              onPressed: () {
                if (idController.text.isNotEmpty) {
                  setState(() {
                    _localRooms.insert(0, {
                      'title': titleController.text.isEmpty ? 'Custom Match' : titleController.text,
                      'id': idController.text,
                      'pass': passController.text.isEmpty ? 'None' : passController.text,
                    });
                  });
                  if (isFirebaseReady) {
                    try {
                      FirebaseFirestore.instance.collection('rooms').add({
                        'title': titleController.text.isEmpty ? 'Custom Match' : titleController.text,
                        'id': idController.text,
                        'pass': passController.text.isEmpty ? 'None' : passController.text,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                    } catch (_) {}
                  }
                  Navigator.pop(ctx);
                }
              },
              child: const Text('PUBLISH ROOM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUSTOM ROOMS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF141424),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _localRooms.length,
        itemBuilder: (context, i) {
          final room = _localRooms[i];
          return Card(
            color: const Color(0xFF16162A),
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              title: Text(room['title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('ID: ${room['id']}  |  Pass: ${room['pass']}', style: const TextStyle(color: Colors.white60)),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E5FF),
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied Room ID: ${room['id']}!')),
                  );
                },
                child: const Text('JOIN', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFF0055),
        onPressed: _showCreateRoomSheet,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('CREATE ROOM', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String userName;
  const ProfileScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GAMER PROFILE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: const Color(0xFF141424),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF00E5FF), width: 3),
              ),
              child: const CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF16162A),
                child: Icon(Icons.sports_esports, size: 50, color: Color(0xFF00E5FF)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              userName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 6),
            const Text('Level: Pro Gamer | Rank: Grandmaster', style: TextStyle(color: Colors.white60)),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF0055)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('LOGOUT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
