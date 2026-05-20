import 'package:flutter/material.dart';
import '../pages/main_navigation.dart';
import '../auth/auth_state.dart';
import '../auth/auth_page.dart';
import '../pages/profil_page.dart';
import '../cerita/cerita_home_page.dart';
import '../cerita/baratayuda.dart';
import '../pages/nakula.dart';
import '../pages/rahwana.dart';

const Color coklat = Color(0xFFBC7647);
const Color coklatMuda = Color(0xFFFFF3E8);
const Color kuning = Color(0xFFFFC107);
const Color abuMuda = Color(0xFFF4F4F4);

class WayangHomePage extends StatefulWidget {
  const WayangHomePage({super.key});

  @override
  State<WayangHomePage> createState() => _WayangHomePageState();
}

class _WayangHomePageState extends State<WayangHomePage> {
  int _selectedIndex = 1;
  String _selectedTab = 'All';

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _characters = [
    {
      'name': 'Nakula',
      'image': 'assets/nakula.png',
      'category': 'Mahabharata',
    },
    {
      'name': 'Sadewa',
      'image': 'assets/sadewa.png',
      'category': 'Mahabharata',
    },
    {
      'name': 'Semar',
      'image': 'assets/semar.png',
      'category': 'Lokal Jawa',
    },
    {
      'name': 'Rahwana',
      'image': 'assets/rahwana.png',
      'category': 'Ramayana',
    },
  ];

  final List<Map<String, dynamic>> _ceritaWayang = [
    {'title': 'Baratayuda', 'image': 'assets/baratayuda.jpg'},
    {'title': 'Ramayana', 'image': 'assets/baratayuda.jpg'},
    {'title': 'Wayang Lokal Jawa', 'image': 'assets/baratayuda.jpg'},
  ];

  List<Map<String, dynamic>> get _filteredCharacters {
    if (_selectedTab == 'All') return _characters;
    return _characters
        .where((c) => c['category'] == _selectedTab)
        .toList();
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

                const Text(
                  'Cerita Pewayangan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 250,

                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: _ceritaWayang.length,

                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },

                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: _ceritaCard(_ceritaWayang[i]),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: List.generate(
                          _ceritaWayang.length,
                          (index) {
                            final active = _currentPage == index;

                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),

                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4),

                              width: active ? 22 : 8,
                              height: 8,

                              decoration: BoxDecoration(
                                color: active
                                    ? coklat
                                    : Colors.grey.shade300,

                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Eksplorasi Wayang',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _filteredCharacters.length,

                  itemBuilder: (context, index) {
                    return _buildVerticalListTile(
                      _filteredCharacters[index],
                    );
                  },
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,

        onTap: (index) {
          // HOME
          if (index == 0) {
            setState(() {
              _selectedIndex = 0;
            });
          }

          // CERITA
          else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CeritaHomePage(),
              ),
            );
          }

          // PROFIL
          else if (index == 2) {
            _handleProfileNavigation();
          }
        },
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Image.asset('assets/wayang.png', width: 42),

          const Icon(Icons.menu_book, color: coklat),
        ],
      ),
    );
  }

  // ================= BANNER =================

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: coklatMuda,
        borderRadius: BorderRadius.circular(14),
      ),

      child: const Text(
        'Mari Mengenal Karakter\nWayang Jawa',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ================= SEARCH =================

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari karakter wayang...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: abuMuda,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= TAB FILTER =================

  Widget _buildTabFilter() {
    final tabs = ['All', 'Mahabharata', 'Ramayana', 'Lokal Jawa'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,

      child: Row(
        children: tabs.map((tab) {
          final active = _selectedTab == tab;

          return GestureDetector(
            onTap: () => setState(() => _selectedTab = tab),

            child: Container(
              margin: const EdgeInsets.only(right: 10),

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: active ? kuning : Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: kuning),
              ),

              child: Text(
                tab,

                style: TextStyle(
                  fontWeight:
                      active ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ================= CARD CERITA =================

  Widget _ceritaCard(Map<String, dynamic> cerita) {
    return GestureDetector(
      onTap: () {
        if (cerita['title'] == 'Baratayuda') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BaratayudaPage(),
            ),
          );
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
              offset: const Offset(0, 4),
            ),
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

              child: Text(
                cerita['title'],

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= LIST WAYANG =================

  Widget _buildVerticalListTile(Map<String, dynamic> char) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),

      onTap: () {
        if (char['name'] == 'Nakula') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NakulaPage(),
            ),
          );
        } else if (char['name'] == 'Rahwana') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RahwanaPage(),
            ),
          );
        }
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),

        decoration: BoxDecoration(
          color: abuMuda,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(char['image']),
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    char['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text('Kategori: ${char['category']}'),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, color: coklat),
          ],
        ),
      ),
    );
  }

  // ================= PROFILE =================

  void _handleProfileNavigation() {
    if (!AuthState.isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthPage(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfilePage(),
        ),
      );
    }
  }
}