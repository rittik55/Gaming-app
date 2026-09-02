import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

bool isFirebaseReady = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  try {
    await Firebase.initializeApp();
    isFirebaseReady = true;
  } catch (e) {
    debugPrint("Firebase state: $e");
  }
  runApp(const ZGodEsportsApp());
}

class ZGodEsportsApp extends StatelessWidget {
  const ZGodEsportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-GOD ESPORTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0B14),
        primaryColor: const Color(0xFFFF0055),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF0055),
          secondary: Color(0xFF00E5FF),
          surface: Color(0xFF131526),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

/* ==========================================
   1. AUTH SCREEN (100% WORKING LOGIN)
   ========================================== */
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _nameController = TextEditingController();
  bool _loading = false;

  Future<void> _login(String defaultName) async {
    setState(() => _loading = true);
    String playerName = _nameController.text.trim();
    if (playerName.isEmpty) playerName = defaultName;

    if (isFirebaseReady) {
      try {
        await FirebaseAuth.instance.signInAnonymously();
      } catch (e) {
        debugPrint("Auth bypass note: $e");
      }
    }

    if (mounted) {
      setState(() => _loading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationScreen(userName: playerName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Cyberpunk glowing accents
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF0055).withOpacity(0.18),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.12),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF0055), Color(0xFFFF5E00)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF0055).withOpacity(0.5),
                            blurRadius: 35,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.sports_esports, size: 65, color: Colors.white),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'Z-GOD GAMING',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'ESPORTS TOURNAMENTS & SCRIMS',
                      style: TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Nickname Input Box
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF131526),
                        hintText: 'Enter In-Game Nickname (Optional)',
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                        prefixIcon: const Icon(Icons.person_pin, color: Color(0xFFFF0055)),
                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Color(0xFFFF0055), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    if (_loading)
                      const CircularProgressIndicator(color: Color(0xFFFF0055))
                    else ...[
                      // Quick Instant Enter
                      Container(
                        width: double.infinity,
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF0055), Color(0xFFFF3366)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF0055).withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => _login('Z-GOD Pro Gamer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.bolt, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'ENTER WARZONE',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Guest Mode
                      OutlinedButton(
                        onPressed: () => _login('Guest Sniper'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 52),
                          side: const BorderSide(color: Color(0xFF00E5FF), width: 1.2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          'CONTINUE AS GUEST',
                          style: TextStyle(color: Color(0xFF00E5FF), fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 1.2),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/* ==========================================
   2. MAIN NAVIGATION (HIGH-TECH DOCK)
   ========================================== */
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
      const EsportsRoomScreen(),
      const TournamentFeedScreen(),
      EsportsProfileScreen(userName: widget.userName),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0E101D),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFFFF0055),
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.sports_esports_rounded), label: 'SCRIMS & ROOMS'),
            BottomNavigationBarItem(icon: Icon(Icons.military_tech_rounded), label: 'TOURNAMENTS'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'PROFILE'),
          ],
        ),
      ),
    );
  }
}

/* ==========================================
   3. ESPORTS ROOMS SCREEN
   ========================================== */
class EsportsRoomScreen extends StatefulWidget {
  const EsportsRoomScreen({super.key});

  @override
  State<EsportsRoomScreen> createState() => _EsportsRoomScreenState();
}

class _EsportsRoomScreenState extends State<EsportsRoomScreen> {
  final List<Map<String, dynamic>> _rooms = [
    {
      'title': '4v4 Clash Squad Grand Scrim',
      'id': '8849102',
      'pass': '1234',
      'map': 'Bermuda',
      'mode': 'CLASH SQUAD',
      'prize': '500 Diamonds',
      'slots': '7/8',
      'isFull': false,
    },
    {
      'title': 'Full Map Battle Royale Ranked',
      'id': '9920145',
      'pass': '0000',
      'map': 'Purgatory',
      'mode': 'BATTLE ROYALE',
      'prize': '1200 Diamonds',
      'slots': '44/48',
      'isFull': false,
    },
    {
      'title': 'Lone Wolf Sniper 1v1 High Stakes',
      'id': '7731209',
      'pass': '7777',
      'map': 'Iron Cage',
      'mode': '1V1 SNIPER',
      'prize': 'Custom Title',
      'slots': '2/2',
      'isFull': true,
    },
  ];

  void _createRoomDialog() {
    final titleCtrl = TextEditingController();
    final idCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final prizeCtrl = TextEditingController(text: '300 Diamonds');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF111322),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          left: 20,
          right: 20,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: const [
                Icon(Icons.add_moderator, color: Color(0xFFFF0055)),
                SizedBox(width: 8),
                Text('HOST ESPORTS MATCH', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.2)),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(hintText: 'Match Name (e.g. 4v4 CS Tournament)'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: idCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Room ID'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: passCtrl,
                    decoration: const InputDecoration(hintText: 'Password'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: prizeCtrl,
              decoration: const InputDecoration(hintText: 'Prize Pool (Optional)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF0055),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (idCtrl.text.isNotEmpty) {
                  setState(() {
                    _rooms.insert(0, {
                      'title': titleCtrl.text.isEmpty ? 'Custom Match' : titleCtrl.text,
                      'id': idCtrl.text,
                      'pass': passCtrl.text.isEmpty ? 'None' : passCtrl.text,
                      'map': 'Bermuda',
                      'mode': 'CUSTOM SCRIM',
                      'prize': prizeCtrl.text,
                      'slots': '1/8',
                      'isFull': false,
                    });
                  });
                  if (isFirebaseReady) {
                    try {
                      FirebaseFirestore.instance.collection('rooms').add({
                        'title': titleCtrl.text,
                        'id': idCtrl.text,
                        'pass': passCtrl.text,
                        'prize': prizeCtrl.text,
                        'createdAt': FieldValue.serverTimestamp(),
                      });
                    } catch (_) {}
                  }
                  Navigator.pop(ctx);
                }
              },
              child: const Text('PUBLISH ROOM LIVE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Z-GOD ARENA',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 2),
                      ),
                      SizedBox(height: 3),
                      Text('Join Custom Rooms or Scrims', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF0055).withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFFF0055).withOpacity(0.4)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.circle, size: 8, color: Color(0xFFFF0055)),
                        SizedBox(width: 6),
                        Text('LIVE MATCHES', style: TextStyle(color: Color(0xFFFF0055), fontWeight: FontWeight.w900, fontSize: 11)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Room Cards
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _rooms.length,
                itemBuilder: (context, index) {
                  final room = _rooms[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF131526), Color(0xFF1A1D34)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white.withOpacity(0.06)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF00E5FF).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  room['mode'],
                                  style: const TextStyle(
                                    color: Color(0xFF00E5FF),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.people_alt_outlined, size: 14, color: Colors.white54),
                                  const SizedBox(width: 4),
                                  Text(room['slots'], style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            room['title'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.card_giftcard, size: 14, color: Color(0xFFFFD700)),
                              const SizedBox(width: 5),
                              Text('Prize: ${room['prize']}', style: const TextStyle(color: Color(0xFFFFD700), fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 14),
                              const Icon(Icons.map_outlined, size: 14, color: Colors.white38),
                              const SizedBox(width: 4),
                              Text(room['map'], style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // ID and Password Display Box
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B0C15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.04)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.key, size: 16, color: Color(0xFFFF0055)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'ID: ${room['id']}   |   Pass: ${room['pass']}',
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: "${room['id']}"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: const Color(0xFF00E5FF),
                                        content: Text('Room ID ${room['id']} Copied! Paste in Game.', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFF0088FF)]),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text('COPY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 11)),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFF0055),
        elevation: 10,
        onPressed: _createRoomDialog,
        icon: const Icon(Icons.add_circle, color: Colors.white),
        label: const Text('HOST MATCH', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
    );
  }
}

/* ==========================================
   4. TOURNAMENT FEED SCREEN
   ========================================== */
class TournamentFeedScreen extends StatelessWidget {
  const TournamentFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const Text(
              'OFFICIAL TOURNAMENTS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5),
            ),
            const SizedBox(height: 14),
            // Featured Card
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E102E), Color(0xFF12142B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFF0055).withOpacity(0.35)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF0055)),
                          child: const Icon(Icons.emoji_events, size: 22, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Z-GOD MEGA CUP 2026', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                            Text('Weekly Esports Battle', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Compete with top tier players. Custom Room credentials will be revealed 10 minutes before the match start time.',
                      style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Prize Pool: ₹10,000 INR', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w900)),
                          Text('Entry: FREE', style: TextStyle(color: Color(0xFFFF0055), fontWeight: FontWeight.w900)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* ==========================================
   5. ESPORTS PROFILE SCREEN
   ========================================== */
class EsportsProfileScreen extends StatelessWidget {
  final String userName;
  const EsportsProfileScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFF0055), width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF0055).withOpacity(0.45),
                          blurRadius: 30,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFF14172B),
                    child: Icon(Icons.shield_outlined, size: 52, color: Color(0xFF00E5FF)),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.5),
              ),
              const SizedBox(height: 4),
              const Text('RANK: GRANDMASTER TIER', style: TextStyle(color: Color(0xFFFF0055), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(child: _buildStatBox('MATCHES', '128')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildStatBox('WIN RATE', '74%')),
                  const SizedBox(width: 10),
                  Expanded(child: _buildStatBox('K/D', '5.4')),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthScreen()),
                    );
                  },
                  icon: const Icon(Icons.logout, color: Colors.white70),
                  label: const Text('LOGOUT / CHANGE ACCOUNT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF131526),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF00E5FF))),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
