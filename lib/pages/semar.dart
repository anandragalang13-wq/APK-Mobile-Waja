import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/wayang_service.dart';
import 'main_navigation.dart';
import 'login.dart';
import 'profil_page.dart';
import '../cerita/cerita_home_page.dart';

const Color _coklat      = Color(0xFFBC7647);
const Color _kuningBg    = Color(0xFFFFF3C7);
const Color _borderCard  = Color(0xFFF4B860);

class SemarPage extends StatefulWidget {
  const SemarPage({super.key});

  @override
  State<SemarPage> createState() => _SemarPageState();
}

class _SemarPageState extends State<SemarPage> {
  static const String _wayangId = 'semar';

  int  _likes     = 0;
  bool _isLiked   = false;
  bool _isSaved   = false;
  bool _loadingLike = false;
  bool _loadingSave = false;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final count = await WayangService.instance.getLikesCount(_wayangId);
    final liked = await WayangService.instance.isLikedWayang(_wayangId);
    final saved = await WayangService.instance.isSavedWayang(_wayangId);
    if (!mounted) return;
    setState(() {
      _likes   = count;
      _isLiked = liked;
      _isSaved = saved;
    });
  }

  Future<void> _toggleLike() async {
    if (FirebaseAuth.instance.currentUser == null) {
      _goLogin();
      return;
    }
    setState(() => _loadingLike = true);
    try {
      final newCount = await WayangService.instance.toggleLikeWayang(_wayangId);
      if (!mounted) return;
      setState(() {
        _likes   = newCount;
        _isLiked = !_isLiked;
      });
    } catch (_) {} finally {
      if (mounted) setState(() => _loadingLike = false);
    }
  }

  Future<void> _toggleSave() async {
    if (FirebaseAuth.instance.currentUser == null) {
      _goLogin();
      return;
    }
    setState(() => _loadingSave = true);
    try {
      final saved = await WayangService.instance.toggleSaveWayang(_wayangId);
      if (!mounted) return;
      setState(() => _isSaved = saved);
    } catch (_) {} finally {
      if (mounted) setState(() => _loadingSave = false);
    }
  }

  void _goLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  void _tampilkanDetail(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.92,
        minChildSize: 0.4,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: ListView(
            controller: ctrl,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(title,
                  style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: _coklat)),
              const SizedBox(height: 14),
              Text(content,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 15, height: 1.6)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String narasiLengkap =
        'Semar adalah tokoh pewayangan Jawa yang paling istimewa dan tidak ada tandingannya. '
        'Ia bukanlah manusia biasa, melainkan penjelmaan dewa dari kahyangan bernama Sang Hyang Ismaya, '
        'kakak tertua Batara Guru (Dewa Siwa). Dalam hierarki kayangan, Semar sebenarnya memiliki '
        'kedudukan yang lebih tinggi dari Batara Guru sendiri, namun ia memilih untuk turun ke bumi '
        'dan menjadi abdi para kesatria Pandawa.\n\n'
        'Penampilan fisik Semar sangat unik dan penuh simbol. Wajahnya bulat seperti bulan purnama, '
        'tubuhnya gemuk dengan punggung yang bungkuk, rambutnya dikuncir satu ke atas, dan ia selalu '
        'tampak tersenyum sekaligus menangis secara bersamaan. Dalam filsafat Jawa, ini melambangkan '
        'keseimbangan antara suka dan duka, lahir dan batin, duniawi dan surgawi.\n\n'
        'Sebagai punakawan utama, Semar berperan sebagai pamong (pengasuh) sekaligus penasihat '
        'spiritual bagi para ksatria mulia. Ia hadir bukan hanya sebagai pelawak, tetapi sebagai '
        'cermin kebenaran. Semar berani menegur siapa pun yang menyimpang dari kebenaran, termasuk '
        'para dewa sekalipun.\n\n'
        'Dalam tradisi pewayangan Jawa, Semar dianggap sebagai simbol rakyat jelata yang sesungguhnya '
        'memegang kebijaksanaan tertinggi. Ia tidak pernah mengambil kekuasaan, tidak pernah '
        'menginginkan harta, namun selalu hadir di sisi para kesatria yang berjuang untuk kebenaran.';

    const String senjataLengkap =
        'Meski Semar bukan dikenal sebagai pejuang atau pendekar pedang, ia memiliki kekuatan gaib '
        'yang luar biasa. Senjata utama Semar adalah kentut saktinya yang bisa meledakkan musuh, '
        'menghancurkan bala tentara raksasa, bahkan membuat para dewa gemetar. Dalam banyak lakon, '
        'senjata "tidak terduga" ini justru menjadi penolong terbesar para Pandawa di saat-saat kritis.\n\n'
        'Selain itu, Semar memiliki kekuatan suara yang bisa menghentikan peperangan seketika. '
        'Tangannya yang menunjuk memiliki kesaktian membuat orang sadar akan kebenaran. Kehadirannya '
        'saja sudah cukup untuk mengusir makhluk jahat dan menetralisir ilmu hitam.\n\n'
        'Yang paling sakti dari Semar adalah kebijaksanaannya. Kata-katanya yang sederhana namun '
        'mengandung makna mendalam mampu membimbing para ksatria menuju jalan yang benar. Ia adalah '
        'bukti bahwa kekuatan sejati bukan berasal dari senjata, melainkan dari hati yang bersih '
        'dan kebijaksanaan yang tulus.';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _coklat),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Semar',
            style: TextStyle(color: _coklat, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          // Tombol Save di AppBar
          _loadingSave
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: _coklat),
                  ),
                )
              : IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved ? _coklat : Colors.grey,
                  ),
                  onPressed: _toggleSave,
                  tooltip: _isSaved ? 'Hapus simpanan' : 'Simpan',
                ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ── Foto Semar ──────────────────────────────────────────────────
            Container(
              height: 260,
              width: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [_kuningBg, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset('assets/semar.png'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'SEMAR',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: _coklat,
                letterSpacing: 1.5,
              ),
            ),

            const Text(
              'Punakawan • Lokal Jawa',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 12),

            // ── Like & Save Row ─────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Like
                _ActionChip(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  iconColor: _isLiked ? Colors.red : Colors.grey,
                  label: '$_likes',
                  loading: _loadingLike,
                  onTap: _toggleLike,
                ),
                const SizedBox(width: 16),
                // Save
                _ActionChip(
                  icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                  iconColor: _isSaved ? _coklat : Colors.grey,
                  label: _isSaved ? 'Tersimpan' : 'Simpan',
                  loading: _loadingSave,
                  onTap: _toggleSave,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Narasi ──────────────────────────────────────────────────────
            _infoCard(
              title: 'Narasi:',
              content: 'Semar adalah penjelmaan dewa Sang Hyang Ismaya yang turun ke bumi '
                  'untuk menjadi pamong para ksatria Pandawa...',
              onTap: () => _tampilkanDetail('Narasi Lengkap Semar', narasiLengkap),
            ),

            // ── Senjata ──────────────────────────────────────────────────────
            _infoCard(
              title: 'Kekuatan & Senjata:',
              content: 'Semar memiliki kekuatan gaib luar biasa. Senjata utamanya adalah '
                  'kentut sakti yang mampu mengalahkan musuh-musuh kuat...',
              onTap: () =>
                  _tampilkanDetail('Kekuatan & Senjata Semar', senjataLengkap),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // ── Bottom Nav (sama seperti halaman utama) ─────────────────────────────
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) {
            Navigator.popUntil(context, (r) => r.isFirst);
          } else if (i == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const CeritaHomePage()));
          } else if (i == 2) {
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const LoginPage()));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
            }
          }
        },
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _borderCard, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: _borderCard.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: _coklat)),
            const SizedBox(height: 8),
            Text(content,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                    fontSize: 14, height: 1.5, color: Colors.black87)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: _coklat,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Selengkapnya',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable action chip (like/save) ──────────────────────────────────────────
class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: loading
            ? const SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2))
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, color: iconColor, size: 20),
                  const SizedBox(width: 6),
                  Text(label,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ],
              ),
      ),
    );
  }
}