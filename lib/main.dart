import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const EsportsTournamentApp());
}

class EsportsTournamentApp extends StatelessWidget {
  const EsportsTournamentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Z-GOD ESPORTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090A10),
        primaryColor: const Color(0xFFFF0055),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF0055),
          secondary: Color(0xFF00E5FF),
          surface: Color(0xFF121422),
        ),
      ),
      home: const EsportsLoginScreen(),
    );
  }
}

/* ==========================================================================
   1. LOGIN SCREEN (ESPORTS STYLE ENTRY)
   ========================================================================== */
class EsportsLoginScreen extends StatefulWidget {
  const EsportsLoginScreen({super.key});

  @override
  State<EsportsLoginScreen> createState() => _EsportsLoginScreenState();
}

class _EsportsLoginScreenState extends State<EsportsLoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();

  void _proceedToApp(String gamerTag, String gameUid) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(
          playerName: gamerTag.isEmpty ? 'Z-GOD WARRIOR' : gamerTag,
          playerUid: gameUid.isEmpty ? '89402102' : gameUid,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glowing Circles
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFF0055).withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.15),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF0055), Color(0xFFFF5E00)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF0055).withOpacity(0.5),
                            blurRadius: 35,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.sports_esports_rounded, size: 65, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Z-GOD ESPORTS',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'TOURNAMENTS & SCRIMS ARENA',
                      style: TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 36),
                    TextField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF131526),
                        hintText: 'Enter In-Game Name (IGN)',
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                        prefixIcon: const Icon(Icons.person, color: Color(0xFFFF0055)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _uidController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFF131526),
                        hintText: 'Game UID (e.g. 59281044)',
                        hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                        prefixIcon: const Icon(Icons.numbers, color: Color(0xFF00E5FF)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 22),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF0055),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 8,
                      ),
                      onPressed: () => _proceedToApp(_nameController.text.trim(), _uidController.text.trim()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.bolt, color: Colors.white),
                          SizedBox(width: 8),
                          Text('LOGIN & ENTER ARENA', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Color(0xFF00E5FF), width: 1.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => _proceedToApp('GUEST PLAYER', '99882211'),
                      child: const Text('PLAY AS GUEST', style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                    ),
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

/* ==========================================================================
   2. MAIN NAVIGATION (ROOTER & BOOYAH DASHBOARD)
   ========================================================================== */
class MainNavigationScreen extends StatefulWidget {
  final String playerName;
  final String playerUid;

  const MainNavigationScreen({super.key, required this.playerName, required this.playerUid});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      TournamentHomeScreen(playerName: widget.playerName, playerUid: widget.playerUid),
      const MyMatchesScreen(),
      WalletProfileScreen(playerName: widget.playerName, playerUid: widget.playerUid),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
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
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 0.8),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.sports_esports_rounded), label: 'TOURNAMENTS'),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark_added_rounded), label: 'MY MATCHES'),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'WALLET & ID'),
          ],
        ),
      ),
    );
  }
}

/* ==========================================================================
   3. TOURNAMENT HOME SCREEN
   ========================================================================== */
class TournamentHomeScreen extends StatefulWidget {
  final String playerName;
  final String playerUid;

  const TournamentHomeScreen({super.key, required this.playerName, required this.playerUid});

  @override
  State<TournamentHomeScreen> createState() => _TournamentHomeScreenState();
}

class _TournamentHomeScreenState extends State<TournamentHomeScreen> {
  String _selectedGame = 'FREE FIRE';

  final List<Map<String, dynamic>> _matches = [
    {
      'id': '101',
      'title': 'FREE FIRE MAX: 4v4 CLASH SQUAD RUSH',
      'game': 'FREE FIRE',
      'time': 'TODAY, 09:30 PM',
      'map': 'Bermuda',
      'type': 'SQUAD (4v4)',
      'entry': 'FREE',
      'prize': '₹500 / 600 💎',
      'perKill': '₹10',
      'totalSlots': 8,
      'joinedSlots': 7,
      'roomId': '8849201',
      'roomPass': '7788',
      'isJoined': false,
    },
    {
      'id': '102',
      'title': 'BATTLE ROYALE: GRANDMASTER SURVIVAL',
      'game': 'FREE FIRE',
      'time': 'TODAY, 10:30 PM',
      'map': 'Purgatory',
      'type': 'SOLO',
      'entry': 'FREE',
      'prize': '₹1,200',
      'perKill': '₹25',
      'totalSlots': 48,
      'joinedSlots': 39,
      'roomId': '9940124',
      'roomPass': '1234',
      'isJoined': false,
    },
    {
      'id': '103',
      'title': 'BGMI: ERANGEL PRO SQUAD WAR',
      'game': 'BGMI',
      'time': 'TOMORROW, 08:00 PM',
      'map': 'Erangel',
      'type': 'SQUAD',
      'entry': 'FREE',
      'prize': '₹2,500',
      'perKill': '₹50',
      'totalSlots': 100,
      'joinedSlots': 82,
      'roomId': '5510293',
      'roomPass': '0000',
      'isJoined': false,
    },
  ];

  void _joinMatchDialog(Map<String, dynamic> match) {
    final ignController = TextEditingController(text: widget.playerName);
    final uidController = TextEditingController(text: widget.playerUid);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF131526),
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
              children: [
                const Icon(Icons.shield, color: Color(0xFFFF0055)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'REGISTER: ${match['type']}',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(match['title'], style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 18),
            TextField(
              controller: ignController,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1B1D34),
                hintText: 'Game In-Game Name (IGN)',
                prefixIcon: const Icon(Icons.person, color: Color(0xFF00E5FF)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: uidController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1B1D34),
                hintText: 'Game UID',
                prefixIcon: const Icon(Icons.numbers, color: Color(0xFFFF0055)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF0055),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                if (ignController.text.isNotEmpty && uidController.text.isNotEmpty) {
                  setState(() {
                    match['isJoined'] = true;
                    match['joinedSlots'] = (match['joinedSlots'] as int) + 1;
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color(0xFF00E5FF),
                      content: Text('Registration Confirmed! Room details unlocked below.', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  );
                }
              },
              child: const Text('CONFIRM REGISTRATION (FREE)', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredMatches = _matches.where((m) => m['game'] == _selectedGame).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFFF0055), Color(0xFFFF5E00)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.flash_on, color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Z-GOD ARENA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                          Text('HELLO, ${widget.playerName.toUpperCase()}', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16182D),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.monetization_on, color: Color(0xFFFFD700), size: 16),
                        SizedBox(width: 6),
                        Text('₹240', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  _buildGameTab('FREE FIRE'),
                  const SizedBox(width: 12),
                  _buildGameTab('BGMI'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredMatches.length,
                itemBuilder: (context, i) {
                  final match = filteredMatches[i];
                  final double progress = (match['joinedSlots'] as int) / (match['totalSlots'] as int);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF131526), Color(0xFF181A30)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: match['isJoined'] ? const Color(0xFF00E5FF).withOpacity(0.6) : Colors.white.withOpacity(0.06),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF0055).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  match['time'],
                                  style: const TextStyle(color: Color(0xFFFF0055), fontSize: 11, fontWeight: FontWeight.w900),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'MAP: ${match['map']}',
                                  style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            match['title'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0C0D17),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildInfoItem('PRIZE POOL', match['prize'], const Color(0xFFFFD700)),
                              _buildInfoItem('PER KILL', match['perKill'], const Color(0xFF00E5FF)),
                              _buildInfoItem('ENTRY', match['entry'], const Color(0xFF00FF66)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Spots Filled: ${match['joinedSlots']}/${match['totalSlots']}',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
                                  ),
                                  Text(
                                    '${((1 - progress) * match['totalSlots']).toInt()} spots left',
                                    style: const TextStyle(fontSize: 11, color: Color(0xFFFF0055), fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 6,
                                  backgroundColor: Colors.white.withOpacity(0.08),
                                  valueColor: const AlwaysStoppedAnimation(Color(0xFFFF0055)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (match['isJoined']) ...[
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E5FF).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.vpn_key_rounded, color: Color(0xFF00E5FF), size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'ROOM ID: ${match['roomId']}  |  PASS: ${match['roomPass']}',
                                    style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Clipboard.setData(ClipboardData(text: "${match['roomId']}"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Room ID ${match['roomId']} Copied! Open Game to Join.')),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00E5FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text('COPY', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 11)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF0055),
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: () => _joinMatchDialog(match),
                              child: const Text('JOIN TOURNAMENT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                            ),
                          ),
                        ],
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

  Widget _buildGameTab(String title) {
    final isSelected = _selectedGame == title;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedGame = title),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFF0055) : const Color(0xFF14162B),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.08)),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 13,
                letterSpacing: 1,
                color: isSelected ? Colors.white : Colors.white60,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 14)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

/* ==========================================================================
   4. MY MATCHES SCREEN
   ========================================================================== */
class MyMatchesScreen extends StatelessWidget {
  const MyMatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY REGISTERED MATCHES', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1)),
        backgroundColor: const Color(0xFF0E101D),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.sports_esports_outlined, size: 64, color: Colors.white24),
              SizedBox(height: 16),
              Text('Your upcoming registered scrims appear here.', style: TextStyle(color: Colors.white54, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

/* ==========================================================================
   5. WALLET & LOGOUT SCREEN
   ========================================================================== */
class WalletProfileScreen extends StatelessWidget {
  final String playerName;
  final String playerUid;

  const WalletProfileScreen({super.key, required this.playerName, required this.playerUid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('PLAYER WALLET', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E102E), Color(0xFF141731)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFF0055).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL EARNINGS', style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('₹240.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF00E5FF))),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF0055),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Withdrawal feature enabled for UPI / Paytm!')),
                            );
                          },
                          icon: const Icon(Icons.account_balance_wallet, size: 16),
                          label: const Text('WITHDRAW', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('PLAYER STATS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),
            const SizedBox(height: 12),
            ListTile(
              tileColor: const Color(0xFF131526),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFF0055),
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(playerName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('UID: $playerUid | Rank: Grandmaster', style: const TextStyle(color: Colors.white54, fontSize: 12)),
              trailing: const Icon(Icons.verified, color: Color(0xFF00E5FF)),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFFF0055)),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const EsportsLoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, color: Color(0xFFFF0055)),
              label: const Text('LOGOUT / CHANGE ACCOUNT', style: TextStyle(color: Color(0xFFFF0055), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
