import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/wayang_service.dart';
import 'main_navigation.dart';
import 'login.dart';
import 'profil_page.dart';
import '../cerita/cerita_home_page.dart';

const Color _coklat     = Color(0xFFBC7647);
const Color _kuningBg   = Color(0xFFFFF3C7);
const Color _borderCard = Color(0xFFF4B860);

class NakulaPage extends StatefulWidget {
  const NakulaPage({super.key});

  @override
  State<NakulaPage> createState() => _NakulaPageState();
}

class _NakulaPageState extends State<NakulaPage> {
  static const String _wayangId = 'nakula';

  int  _likes      = 0;
  bool _isLiked    = false;
  bool _isSaved    = false;
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
    if (FirebaseAuth.instance.currentUser == null) { _goLogin(); return; }
    setState(() => _loadingLike = true);
    try {
      final newCount = await WayangService.instance.toggleLikeWayang(_wayangId);
      if (!mounted) return;
      setState(() { _likes = newCount; _isLiked = !_isLiked; });
    } catch (_) {} finally {
      if (mounted) setState(() => _loadingLike = false);
    }
  }

  Future<void> _toggleSave() async {
    if (FirebaseAuth.instance.currentUser == null) { _goLogin(); return; }
    setState(() => _loadingSave = true);
    try {
      final saved = await WayangService.instance.toggleSaveWayang(_wayangId);
      if (!mounted) return;
      setState(() => _isSaved = saved);
    } catch (_) {} finally {
      if (mounted) setState(() => _loadingSave = false);
    }
  }

  void _goLogin() =>
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));

  void _tampilkanDetail(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6, maxChildSize: 0.92, minChildSize: 0.4,
        builder: (_, ctrl) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: ListView(controller: ctrl, children: [
            Center(child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            )),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: _coklat)),
            const SizedBox(height: 14),
            Text(content,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 15, height: 1.6)),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const String narasiLengkap =
        'Nakula adalah salah satu dari lima Pandawa dalam kisah Mahabharata dan pewayangan Jawa. '
        'Ia merupakan putra keempat Prabu Pandu dari Dewi Madrim serta saudara kembar Sadewa. '
        'Nakula dikenal sebagai ksatria yang memiliki wajah sangat tampan, tutur kata lembut, '
        'dan sikap penuh kesopanan.\n\n'
        'Sebagai seorang ksatria, Nakula memiliki kemampuan bertarung yang baik dan mahir menggunakan '
        'pedang maupun tombak. Ia juga dikenal sebagai penunggang kuda terbaik di antara para Pandawa. '
        'Kepandaiannya dalam merawat serta melatih kuda membuatnya dihormati sebagai ahli peternakan '
        'dan pertanian.\n\n'
        'Kekuatan terbesar Nakula terletak pada sifatnya yang tulus dan setia. Ia selalu menjaga '
        'keharmonisan keluarga serta menghormati saudara-saudaranya tanpa rasa iri maupun ambisi '
        'berlebihan. Nakula dikenal jujur, sabar, dan mampu menenangkan suasana ketika terjadi '
        'perselisihan.\n\n'
        'Dalam perang besar Bharatayudha, peran Nakula memang tidak sepopuler Arjuna dengan panah '
        'Gandiva atau Bima dengan gada Rujakpala. Namun, kehadirannya tetap memiliki arti penting '
        'dalam menjaga kekuatan dan keseimbangan Pandawa.';

    const String senjataLengkap =
        'Nakula dikenal sebagai ksatria Pandawa yang mahir menggunakan pedang bernama Pedang Soka '
        'dan tombak sebagai senjata utamanya. Gerakannya cepat, lincah, dan penuh keanggunan.\n\n'
        'Senjata sejati Nakula sebenarnya adalah ketampanannya, kelembutan hati, dan kesetiaan. '
        'Dengan tutur kata yang menyejukkan, ia mampu meredakan pertikaian dan menjaga hubungan '
        'baik dengan orang lain.\n\n'
        'Nakula adalah simbol bahwa kekuatan sejati tidak selalu berasal dari keberanian di medan '
        'perang, melainkan juga dari kelembutan hati yang mampu menjaga keseimbangan hidup.';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _coklat),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Nakula',
            style: TextStyle(color: _coklat, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          _loadingSave
              ? const Padding(padding: EdgeInsets.all(14),
                  child: SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: _coklat)))
              : IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved ? _coklat : Colors.grey,
                  ),
                  onPressed: _toggleSave,
                ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 10),

          // Foto
          Container(
            height: 260, width: 260,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(colors: [_kuningBg, Colors.white]),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset('assets/nakula.png'),
            ),
          ),

          const SizedBox(height: 10),

          const Text('NAKULA',
              style: TextStyle(
                  fontSize: 26, fontWeight: FontWeight.w900,
                  color: _coklat, letterSpacing: 1.5)),

          const Text('Pandawa • Mahabharata',
              style: TextStyle(color: Colors.grey, fontSize: 13)),

          const SizedBox(height: 12),

          // Like & Save
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ActionChip(
                icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                iconColor: _isLiked ? Colors.red : Colors.grey,
                label: '$_likes',
                loading: _loadingLike,
                onTap: _toggleLike,
              ),
              const SizedBox(width: 16),
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

          _infoCard(
            title: 'Narasi:',
            content: 'Nakula adalah salah satu dari lima Pandawa, putra keempat '
                'Prabu Pandu dari Dewi Madrim...',
            onTap: () => _tampilkanDetail('Narasi Lengkap Nakula', narasiLengkap),
          ),

          _infoCard(
            title: 'Senjata:',
            content: 'Nakula mahir menggunakan Pedang Soka dan tombak. Namun senjata '
                'sejatinya adalah kelembutan hati dan kesetiaan...',
            onTap: () => _tampilkanDetail('Senjata & Kekuatan Nakula', senjataLengkap),
          ),

          const SizedBox(height: 30),
        ]),
      ),

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
              offset: const Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: _coklat)),
          const SizedBox(height: 8),
          Text(content,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, height: 1.5)),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                    color: _coklat, borderRadius: BorderRadius.circular(20)),
                child: const Text('Selengkapnya',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool loading;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon, required this.iconColor,
    required this.label, required this.loading, required this.onTap,
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
            ? const SizedBox(width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2))
            : Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 6),
                Text(label,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
              ]),
      ),
    );
  }
}