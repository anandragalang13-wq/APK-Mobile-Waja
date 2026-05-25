import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/auth_service.dart';
import '../auth/auth_state.dart';
import '../services/wayang_service.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color coklat      = Color(0xFFBC7647);
  static const Color coklatGelap = Color(0xFF8B5320);
  static const Color krem        = Color(0xFFF5EDE0);

  bool _uploadingPhoto = false;

  // ─── LOGOUT ─────────────────────────────────────────────────────────────────
  Future<void> _logout() async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Keluar',
            style: TextStyle(fontWeight: FontWeight.bold, color: coklatGelap)),
        content: const Text('Yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: coklat,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (konfirmasi != true) return;

    await AuthService.instance.signOut();

    if (!mounted) return;
    // pushAndRemoveUntil agar tidak bisa back ke halaman profil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  // ─── EDIT PROFIL ─────────────────────────────────────────────────────────────
  void _editProfile() {
    final nameCtrl = TextEditingController(text: AuthState.username);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(builder: (ctx, setModalState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50, height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Edit Profil',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),

                  // ── Foto Profil dengan tombol upload ──────────────────────
                  GestureDetector(
                    onTap: () async {
                      setModalState(() {});
                      final choice = await _showImageSourceDialog();
                      if (choice == null) return;

                      setModalState(() => _uploadingPhoto = true);
                      try {
                        final url = await WayangService.instance
                            .uploadFotoProfil(fromCamera: choice == 'camera');
                        if (url != null && mounted) {
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Foto profil diperbarui!')),
                          );
                        }
                      } finally {
                        setModalState(() => _uploadingPhoto = false);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        // Foto profil
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: krem,
                          backgroundImage: AuthState.photoUrl != null &&
                                  AuthState.photoUrl!.isNotEmpty
                              ? NetworkImage(AuthState.photoUrl!) as ImageProvider
                              : const AssetImage('assets/orang.jpg'),
                          child: _uploadingPhoto
                              ? const CircularProgressIndicator(
                                  strokeWidth: 2, color: coklat)
                              : null,
                        ),
                        // Tombol kamera
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: const BoxDecoration(
                            color: coklat,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt,
                              color: Colors.white, size: 16),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),
                  const Text('Ketuk foto untuk mengganti',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 20),

                  // Username
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person, color: coklat),
                      filled: true,
                      fillColor: krem,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: coklat),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: coklat,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () async {
                        await AuthService.instance.updateProfile(
                          uid: AuthState.uid,
                          username: nameCtrl.text.trim(),
                        );
                        if (!mounted) return;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Simpan Perubahan',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  Future<String?> _showImageSourceDialog() async {
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Pilih Sumber Foto',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.photo_library, color: coklat),
            title: const Text('Galeri'),
            onTap: () => Navigator.pop(ctx, 'gallery'),
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: coklat),
            title: const Text('Kamera'),
            onTap: () => Navigator.pop(ctx, 'camera'),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      appBar: AppBar(
        backgroundColor: coklat,
        foregroundColor: Colors.white,
        title: const Text('Profil',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(children: [

          // ── Header dengan foto ────────────────────────────────────────────
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: coklat,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32)),
            ),
            padding: const EdgeInsets.only(bottom: 32, top: 16),
            child: Column(children: [
              // Avatar
              CircleAvatar(
                radius: 52,
                backgroundColor: Colors.white,
                backgroundImage: user?.photoURL != null &&
                        user!.photoURL!.isNotEmpty
                    ? NetworkImage(user.photoURL!) as ImageProvider
                    : const AssetImage('assets/orang.jpg'),
              ),
              const SizedBox(height: 14),
              Text(
                AuthState.username,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                AuthState.email,
                style: const TextStyle(
                    fontSize: 13, color: Colors.white70),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit, size: 16,
                    color: Colors.white),
                label: const Text('Edit Profil',
                    style: TextStyle(color: Colors.white)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ]),
          ),

          const SizedBox(height: 24),

          // ── Wayang Disukai ────────────────────────────────────────────────
          _SectionHeader(
              icon: Icons.favorite, title: 'Wayang Disukai', color: Colors.red),
          const SizedBox(height: 12),
          _LikedWayangList(uid: user?.uid ?? ''),

          const SizedBox(height: 24),

          // ── Wayang Disimpan ───────────────────────────────────────────────
          _SectionHeader(
              icon: Icons.bookmark, title: 'Wayang Disimpan', color: coklat),
          const SizedBox(height: 12),
          _SavedWayangList(uid: user?.uid ?? ''),

          const SizedBox(height: 32),

          // ── Tombol Logout ─────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Keluar',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: coklat,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _logout,
              ),
            ),
          ),

          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}

// ── Section Header ─────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  const _SectionHeader(
      {required this.icon, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

// ── Liked Wayang dari Firestore ────────────────────────────────────────────────
class _LikedWayangList extends StatelessWidget {
  final String uid;
  const _LikedWayangList({required this.uid});

  static const Map<String, Map<String, String>> _wayangInfo = {
    'nakula':  {'name': 'Nakula',  'image': 'assets/nakula.png',  'kategori': 'Mahabharata'},
    'sadewa':  {'name': 'Sadewa',  'image': 'assets/sadewa.png',  'kategori': 'Mahabharata'},
    'semar':   {'name': 'Semar',   'image': 'assets/semar.png',   'kategori': 'Lokal Jawa'},
    'rahwana': {'name': 'Rahwana', 'image': 'assets/rahwana.png', 'kategori': 'Ramayana'},
  };

  @override
  Widget build(BuildContext context) {
    if (uid.isEmpty) return const _EmptyCard(msg: 'Login untuk melihat');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('liked_wayang')
          .orderBy('likedAt', descending: true)
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snap.data?.docs ?? [];
        if (docs.isEmpty) {
          return const _EmptyCard(
              msg: 'Belum ada wayang yang disukai', icon: Icons.favorite_border);
        }
        return SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final id   = docs[i].id;
              final info = _wayangInfo[id] ??
                  {'name': id, 'image': 'assets/nakula.png', 'kategori': ''};
              return _WayangMiniCard(
                name: info['name']!,
                image: info['image']!,
                kategori: info['kategori']!,
                icon: Icons.favorite,
                iconColor: Colors.red,
              );
            },
          ),
        );
      },
    );
  }
}

// ── Saved Wayang dari Firestore ────────────────────────────────────────────────
class _SavedWayangList extends StatelessWidget {
  final String uid;
  const _SavedWayangList({required this.uid});

  static const Map<String, Map<String, String>> _wayangInfo = {
    'nakula':  {'name': 'Nakula',  'image': 'assets/nakula.png',  'kategori': 'Mahabharata'},
    'sadewa':  {'name': 'Sadewa',  'image': 'assets/sadewa.png',  'kategori': 'Mahabharata'},
    'semar':   {'name': 'Semar',   'image': 'assets/semar.png',   'kategori': 'Lokal Jawa'},
    'rahwana': {'name': 'Rahwana', 'image': 'assets/rahwana.png', 'kategori': 'Ramayana'},
  };

  @override
  Widget build(BuildContext context) {
    if (uid.isEmpty) return const _EmptyCard(msg: 'Login untuk melihat');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved_wayang')
          .orderBy('savedAt', descending: true)
          .snapshots(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final docs = snap.data?.docs ?? [];
        if (docs.isEmpty) {
          return const _EmptyCard(
              msg: 'Belum ada wayang yang disimpan',
              icon: Icons.bookmark_border);
        }
        return SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final id   = docs[i].id;
              final info = _wayangInfo[id] ??
                  {'name': id, 'image': 'assets/nakula.png', 'kategori': ''};
              return _WayangMiniCard(
                name: info['name']!,
                image: info['image']!,
                kategori: info['kategori']!,
                icon: Icons.bookmark,
                iconColor: const Color(0xFFBC7647),
              );
            },
          ),
        );
      },
    );
  }
}

// ── Card mini wayang modern ────────────────────────────────────────────────────
class _WayangMiniCard extends StatelessWidget {
  final String name;
  final String image;
  final String kategori;
  final IconData icon;
  final Color iconColor;

  const _WayangMiniCard({
    required this.name, required this.image,
    required this.kategori, required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(image,
                    width: 64, height: 64, fit: BoxFit.contain),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Icon(icon, size: 14, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13)),
          Text(kategori,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

// ── Empty state ────────────────────────────────────────────────────────────────
class _EmptyCard extends StatelessWidget {
  final String msg;
  final IconData? icon;
  const _EmptyCard({required this.msg, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null)
            Icon(icon, size: 32, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(msg,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
        ]),
      ),
    );
  }
}