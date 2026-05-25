import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main_navigation.dart';
import '../cerita/cerita_home_page.dart';
import '../cerita/baratayuda.dart';
import 'nakula.dart';
import 'rahwana.dart';
import 'semar.dart';
import 'login.dart';
import 'profil_page.dart';

const Color coklat     = Color(0xFFBC7647);
const Color coklatMuda = Color(0xFFFFF3E8);
const Color kuning     = Color(0xFFFFC107);
const Color abuMuda    = Color(0xFFF4F4F4);

class WayangHomePage extends StatefulWidget {
  const WayangHomePage({super.key});

  @override
  State<WayangHomePage> createState() => _WayangHomePageState();
}

class _WayangHomePageState extends State<WayangHomePage> {
  int _selectedIndex = 0;
  String _selectedTab = 'All';

  final PageController _pageController = PageController();
  int _currentPage = 0;
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _characters = [
    {'name': 'Nakula',  'image': 'assets/nakula.png',  'category': 'Mahabharata'},
    {'name': 'Sadewa',  'image': 'assets/sadewa.png',  'category': 'Mahabharata'},
    {'name': 'Semar',   'image': 'assets/semar.png',   'category': 'Lokal Jawa'},
    {'name': 'Rahwana', 'image': 'assets/rahwana.png', 'category': 'Ramayana'},
  ];

  final List<Map<String, dynamic>> _ceritaWayang = [
    {'title': 'Baratayuda',    'image': 'assets/baratayuda.jpg'},
    {'title': 'Ramayana',      'image': 'assets/baratayuda.jpg'},
    {'title': 'Wayang Lokal Jawa', 'image': 'assets/baratayuda.jpg'},
  ];

  List<Map<String, dynamic>> get _filteredCharacters {
    var list = _selectedTab == 'All'
        ? _characters
        : _characters.where((c) => c['category'] == _selectedTab).toList();

    if (_searchQuery.isNotEmpty) {
      list = list
          .where((c) => (c['name'] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()))
          .toList();
    }
    return list;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _navigateToWayang(String name) {
    switch (name) {
      case 'Nakula':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const NakulaPage()));
        break;
      case 'Semar':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SemarPage()));
        break;
      case 'Rahwana':
        Navigator.push(context, MaterialPageRoute(builder: (_) => const RahwanaPage()));
        break;
      default:
        // Sadewa dan tokoh lain: bisa ditambah halaman nanti
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Halaman $name akan segera hadir!'),
            backgroundColor: coklat,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
    }
  }

  void _handleProfileNavigation() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildBanner(),
                const SizedBox(height: 16),
                _buildSearchBar(),
                const SizedBox(height: 16),
                _buildTabFilter(),
                const SizedBox(height: 22),

                const Text('Cerita Pewayangan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                // Carousel cerita
                SizedBox(
                  height: 250,
                  child: Column(children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _ceritaWayang.length,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _ceritaCard(_ceritaWayang[i]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_ceritaWayang.length, (i) {
                        final active = _currentPage == i;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: active ? 22 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active ? coklat : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }),
                    ),
                  ]),
                ),

                const SizedBox(height: 24),
                const Text('Eksplorasi Wayang',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                // List wayang
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (_, i) =>
                      _buildWayangCard(_filteredCharacters[i]),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: (i) {
          if (i == 0) {
            setState(() => _selectedIndex = 0);
          } else if (i == 1) {
            setState(() => _selectedIndex = 1);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CeritaHomePage()));
          } else if (i == 2) {
            setState(() => _selectedIndex = 2);
            _handleProfileNavigation();
          }
        },
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/wayang.png', width: 42),
          // Greeting
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, snap) {
              final name = snap.data?.displayName?.split(' ').first ?? 'Tamu';
              return Text(
                'Halo, $name 👋',
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: coklat, fontSize: 15),
              );
            },
          ),
          const Icon(Icons.menu_book, color: coklat),
        ],
      ),
    );
  }

  // ── Banner ─────────────────────────────────────────────────────────────────
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF3E8), Color(0xFFFFE0C0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(children: [
        const Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Mari Mengenal',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text('Karakter Wayang Jawa',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: coklat)),
            SizedBox(height: 8),
            Text('Pelajari budaya Jawa kapan saja',
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ]),
        ),
        Image.asset('assets/wayang.png', width: 70, opacity: const AlwaysStoppedAnimation(0.8)),
      ]),
    );
  }

  // ── Search ─────────────────────────────────────────────────────────────────
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (v) => setState(() => _searchQuery = v),
      decoration: InputDecoration(
        hintText: 'Cari karakter wayang...',
        prefixIcon: const Icon(Icons.search, color: coklat),
        suffixIcon: _searchQuery.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  _searchCtrl.clear();
                  setState(() => _searchQuery = '');
                },
              )
            : null,
        filled: true,
        fillColor: abuMuda,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ── Tab filter ─────────────────────────────────────────────────────────────
  Widget _buildTabFilter() {
    final tabs = ['All', 'Mahabharata', 'Ramayana', 'Lokal Jawa'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((tab) {
          final active = _selectedTab == tab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = tab),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: active ? kuning : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: active ? kuning : Colors.grey.shade300),
                boxShadow: active
                    ? [BoxShadow(color: kuning.withOpacity(0.4), blurRadius: 6)]
                    : [],
              ),
              child: Text(tab,
                  style: TextStyle(
                      fontWeight:
                          active ? FontWeight.bold : FontWeight.w500)),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Card cerita (carousel) ──────────────────────────────────────────────────
  Widget _ceritaCard(Map<String, dynamic> cerita) {
    return GestureDetector(
      onTap: () {
        if (cerita['title'] == 'Baratayuda') {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const BaratayudaPage()));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          image: DecorationImage(
            image: AssetImage(cerita['image']),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.65),
                Colors.transparent,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(cerita['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }

  // ── Card wayang modern ──────────────────────────────────────────────────────
  Widget _buildWayangCard(Map<String, dynamic> char) {
    return GestureDetector(
      onTap: () => _navigateToWayang(char['name'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(children: [
          // Foto
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: coklatMuda,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(char['image']),
            ),
          ),
          const SizedBox(width: 14),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(char['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: coklatMuda,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(char['category'],
                      style: const TextStyle(
                          fontSize: 11,
                          color: coklat,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          // Arrow
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: coklatMuda,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_forward, color: coklat, size: 18),
          ),
        ]),
      ),
    );
  }
}