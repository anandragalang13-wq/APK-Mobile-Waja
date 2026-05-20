import 'package:flutter/material.dart';

const Color coklatNav = Color(0xFFBC7647);
const Color kuningLingkaran = Color(0xFFFFF3C7);
const Color borderCard = Color(0xFFF4B860);

class NakulaPage extends StatefulWidget {
  const NakulaPage({super.key});

  @override
  State<NakulaPage> createState() => _NakulaPageState();
}

class _NakulaPageState extends State<NakulaPage> {
  int likes = 320;
  int _currentIndex = 1;

  // ================= BOTTOM SHEET =================
  void _tampilkanDetail(BuildContext context, String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: coklatNav,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  content,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 15, height: 1.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const String narasiLengkap =
        "Nakula adalah salah satu dari lima Pandawa, putra keempat Pandu dari pasangan Dewi Madrim. "
        "Ia merupakan saudara kembar Sadewa. Dalam kisah Mahabharata maupun pewayangan Jawa, "
        "Nakula dikenal memiliki wajah tampan, perangai lembut, dan hati yang penuh kasih sayang. "
        "Karakternya halus, sopan, serta tidak suka menonjolkan diri, sehingga sering dipandang "
        "sebagai Pandawa yang paling rendah hati.\n\n"
        "Selain ketampanannya, Nakula juga memiliki kepandaian dalam merawat kuda. Ia dianggap "
        "sebagai penunggang kuda terbaik di antara Pandawa, bahkan dijuluki sebagai ahli ilmu "
        "pertanian dan peternakan. Sifat utamanya adalah kesetiaan dan kejujuran, yang menjadikannya "
        "teladan dalam menjaga keharmonisan keluarga. Dalam budaya Jawa, Nakula dipandang sebagai "
        "lambang ketulusan hati serta kesempurnaan lahir dan batin.\n\n"
        "Dalam perang besar Bharatayudha, Nakula tidak sepopuler Arjuna atau Bima, tetapi perannya "
        "tetap penting. Ia selalu siap mendukung strategi Pandawa dan menjadi bagian dari "
        "keseimbangan lima bersaudara, melengkapi sifat-sifat saudaranya yang lain.";

    const String senjataLengkap =
        "Nakula tidak terkenal dengan senjata pusaka tertentu seperti Gandiva milik Arjuna atau "
        "gada Rujakpala milik Bima. Senjata sejatinya adalah ketampanan, kelembutan hati, dan "
        "kesetiaan. Dengan tutur kata yang menyejukkan, ia mampu meredakan pertikaian dan menjaga "
        "hubungan baik dengan orang lain.\n\n"
        "Dalam beberapa lakon, Nakula juga digambarkan mahir menggunakan pedang dan tombak, serta "
        "memiliki kuda andalan yang gagah perkasa. Namun, yang paling dihargai dari Nakula adalah "
        "sifatnya yang tulus dan jujur, menjadikannya simbol bahwa kekuatan sejati tidak selalu "
        "berasal dari keberanian di medan perang, melainkan juga dari kelembutan hati yang mampu "
        "menjaga keseimbangan hidup.";

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: coklatNav),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.menu, color: coklatNav),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // ================= FOTO =================
            Container(
              height: 260,
              width: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [kuningLingkaran, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset('assets/nakula.png'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "NAKULA",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: coklatNav,
                letterSpacing: 1.5,
              ),
            ),

            const SizedBox(height: 8),

            // ================= LIKE =================
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    setState(() => likes++);
                  },
                ),
                Text(likes.toString(), style: const TextStyle(fontSize: 14)),
              ],
            ),

            const SizedBox(height: 15),

            // ================= NARASI =================
            _infoCard(
              title: "Narasi:",
              content:
                  "Nakula adalah salah satu dari lima Pandawa, putra keempat Pandu...",
              onTap: () => _tampilkanDetail(
                context,
                "Narasi Lengkap Nakula",
                narasiLengkap,
              ),
            ),

            // ================= SENJATA =================
            _infoCard(
              title: "Senjata:",
              content:
                  "Nakula tidak terkenal dengan senjata pusaka tertentu...",
              onTap: () => _tampilkanDetail(
                context,
                "Senjata Sejati Nakula",
                senjataLengkap,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        backgroundColor: coklatNav,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() => _currentIndex = i);

          if (i == 0) {
            Navigator.pop(context); // kembali ke Beranda
          } else if (i == 1) {
            // Kembali ke Home/Beranda
            Navigator.pop(context);
          } else if (i == 2) {
            // Pindah ke halaman Profil (Ganti 'ProfilePage' dengan nama class halamanmu)
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  // ================= CARD =================
  Widget _infoCard({
    required String title,
    required String content,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: borderCard, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Text(content, textAlign: TextAlign.justify),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Selengkapnya",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
