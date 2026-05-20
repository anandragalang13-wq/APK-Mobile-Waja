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
        "Nakula adalah salah satu dari lima Pandawa dalam kisah Mahabharata dan pewayangan Jawa. "
        "Ia merupakan putra keempat Prabu Pandu dari Dewi Madrim serta saudara kembar Sadewa. "
        "Dalam berbagai kisah pewayangan, Nakula dikenal sebagai ksatria yang memiliki wajah sangat "
        "tampan, tutur kata lembut, dan sikap penuh kesopanan. Karakternya tenang serta tidak suka "
        "menonjolkan diri, sehingga ia sering dipandang sebagai sosok Pandawa yang paling rendah hati "
        "dan halus budi pekertinya.\n\n"
        "Sebagai seorang ksatria, Nakula memiliki kemampuan bertarung yang baik dan mahir menggunakan "
        "pedang maupun tombak. Ia juga dikenal sebagai penunggang kuda terbaik di antara para Pandawa. "
        "Kepandaiannya dalam merawat serta melatih kuda membuatnya dihormati sebagai ahli peternakan "
        "dan pertanian. Dalam budaya pewayangan Jawa, kemampuan tersebut melambangkan kecermatan, "
        "ketekunan, dan kedekatan manusia dengan alam.\n\n"
        "Selain memiliki ketampanan dan kemampuan perang, kekuatan terbesar Nakula sebenarnya terletak "
        "pada sifatnya yang tulus dan setia. Ia selalu menjaga keharmonisan keluarga serta menghormati "
        "saudara-saudaranya tanpa rasa iri maupun ambisi berlebihan. Nakula dikenal jujur, sabar, dan "
        "mampu menenangkan suasana ketika terjadi perselisihan. Karena sifat inilah ia menjadi simbol "
        "kesempurnaan lahir dan batin dalam pandangan budaya Jawa.\n\n"
        "Dalam perang besar Bharatayudha, peran Nakula memang tidak sepopuler Arjuna dengan panah "
        "Gandiva atau Bima dengan gada Rujakpala. Namun, kehadirannya tetap memiliki arti penting "
        "dalam menjaga kekuatan dan keseimbangan Pandawa. Ia selalu siap mendukung strategi perang, "
        "melindungi saudara-saudaranya, serta menjalankan tugas dengan penuh tanggung jawab.\n\n"
        "Dalam dunia pewayangan, sosok Nakula mengajarkan bahwa kekuatan sejati tidak selalu ditunjukkan "
        "melalui keberanian di medan perang atau kehebatan senjata. Ketulusan hati, kesetiaan, "
        "kerendahan hati, dan kemampuan menjaga keharmonisan juga merupakan bentuk kekuatan yang sangat "
        "berharga dalam kehidupan.";

    const String senjataLengkap =
        "Nakula dikenal sebagai ksatria Pandawa yang mahir menggunakan pedang dan tombak sebagai "
        "senjata utamanya. Dalam berbagai kisah Mahabharata dan pewayangan Jawa, ia digambarkan "
        "memiliki gerakan bertarung yang cepat, lincah, dan penuh keanggunan. Keahliannya dalam "
        "menggunakan senjata membuat Nakula mampu menghadapi lawan dengan ketepatan serta ketenangan, "
        "tanpa dipenuhi amarah berlebihan. Sebagai seorang kesatria, ia juga dikenal memiliki "
        "kemampuan berkuda yang sangat baik dan sering digambarkan menunggang kuda gagah yang "
        "melambangkan kewibawaan serta ketangkasannya.\n\n"
        "Meskipun tidak memiliki senjata pusaka seterkenal Gandiva milik Arjuna atau gada Rujakpala "
        "milik Bima, kemampuan Nakula tetap sangat dihormati. Dalam budaya pewayangan Jawa, kekuatan "
        "seorang ksatria tidak hanya diukur dari kehebatan senjatanya, tetapi juga dari kebijaksanaan "
        "dan keluhuran budi pekerti yang dimilikinya. Karena itu, Nakula lebih dikenal melalui "
        "karakter halus dan sikap rendah hatinya dibandingkan ambisi untuk menunjukkan kekuatan.\n\n"
        "Selain keahliannya dalam bertarung, Nakula juga dikenal memiliki wajah yang tampan serta "
        "kepribadian yang lembut. Ia memiliki hati penuh kasih sayang, setia kepada keluarga, dan "
        "selalu menjunjung kejujuran dalam setiap tindakannya. Tutur katanya yang sopan dan menyejukkan "
        "sering membuatnya mampu meredakan pertikaian serta menjaga hubungan baik dengan orang-orang "
        "di sekitarnya. Sifat tersebut menjadikan Nakula sebagai sosok yang dihormati bukan karena "
        "ketakutan, melainkan karena ketulusan hatinya.\n\n"
        "Dalam kisah Bharatayudha, Nakula memang tidak banyak menjadi pusat perhatian dibandingkan "
        "Arjuna atau Bima. Namun, perannya tetap penting sebagai penjaga keseimbangan di antara "
        "saudara-saudaranya. Ia selalu siap membantu perjuangan Pandawa dengan penuh tanggung jawab "
        "dan kesetiaan tanpa mengharapkan pujian.\n\n"
        "Dalam pandangan budaya Jawa, sosok Nakula melambangkan kesempurnaan lahir dan batin. "
        "Ia mengajarkan bahwa kekuatan sejati tidak selalu berasal dari keberanian di medan perang "
        "atau kehebatan senjata, tetapi juga dari kelembutan hati, kesabaran, kejujuran, dan "
        "kemampuan menjaga keharmonisan hidup.";

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
