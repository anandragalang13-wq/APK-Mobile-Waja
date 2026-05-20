import 'package:flutter/material.dart';
import '../auth/auth_state.dart';
import 'login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color coklat = Color(0xFFB87333);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ===== APP BAR =====
      appBar: AppBar(
        backgroundColor: coklat,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profil'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ===== HEADER =====
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/bayangan-orang.jpg',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -40,
                  left: 20,
                  child: CircleAvatar(
                    radius: 46,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 42,
                      backgroundImage: AssetImage('assets/orang.jpg'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // ===== USER INFO =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthState.username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        AuthState.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: _editProfile,
                    child: const Text('Edit Profil'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ===== CERITA DISUKAI =====
            const SectionTitle(
              icon: Icons.favorite,
              title: 'Cerita Disukai',
              color: Colors.red,
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                StoryCard(
                  image: 'assets/baratayuda.jpg',
                  title: 'Baratayuda',
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                ),
                StoryCard(
                  image: 'assets/nakula.png',
                  title: 'Nakula',
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ===== CERITA DISIMPAN =====
            const SectionTitle(
              icon: Icons.bookmark,
              title: 'Cerita Disimpan',
              color: Colors.blue,
            ),

            const SizedBox(height: 12),

            Row(
              children: const [
                StoryCard(
                  image: 'assets/rahwana.png',
                  title: 'Rahwana',
                  icon: Icons.bookmark,
                  iconColor: Colors.blue,
                ),
                StoryCard(
                  image: 'assets/baratayuda.jpg',
                  title: 'Baratayuda',
                  icon: Icons.bookmark,
                  iconColor: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ===== LOGOUT =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: coklat,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: _logout,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ===== LOGOUT =====
  void _logout() {
    AuthState.isLoggedIn = false;
    AuthState.username = '';
    AuthState.email = '';

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  // ===== EDIT PROFIL =====
void _editProfile() {
  final nameCtrl = TextEditingController(text: AuthState.username);
  final emailCtrl = TextEditingController(text: AuthState.email);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(28),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              // garis atas
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Edit Profil',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // FOTO PROFIL
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/orang.jpg'),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: coklat,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // USERNAME
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // EMAIL
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // TOMBOL
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      AuthState.username = nameCtrl.text;
                      AuthState.email = emailCtrl.text;
                    });

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: coklat,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Simpan Perubahan',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      );
    },
  );
}
}

//
// ===== WIDGET PENDUKUNG =====
//

class SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const SectionTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryCard extends StatelessWidget {
  final String image;
  final String title;
  final IconData icon;
  final Color iconColor;

  const StoryCard({
    super.key,
    required this.image,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(image, height: 80),
                Positioned(
                  right: 0,
                  child: Icon(icon, color: iconColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
