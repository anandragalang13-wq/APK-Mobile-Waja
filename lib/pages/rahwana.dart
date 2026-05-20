import 'package:flutter/material.dart';

/// ================= WARNA =================
const Color coklatNav = Color(0xFFBC7647);
const Color kuningLingkaran = Color(0xFFFFF3C7);
const Color borderCard = Color(0xFFF4B860);

class RahwanaPage extends StatefulWidget {
  const RahwanaPage({super.key});

  @override
  State<RahwanaPage> createState() => _RahwanaPageState();
}

class _RahwanaPageState extends State<RahwanaPage> {
  int likes = 320;
  int _currentIndex = 1;

  /// ================= BOTTOM SHEET DETAIL =================
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
                  style: const TextStyle(fontSize: 15, height: 1.6),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ================= DATA NARASI =================
  final String narasiLengkap =
  "Rahwana adalah raja Kerajaan Alengka yang terkenal karena kekuasaan, kesaktian, dan "
"pengaruh besarnya dalam kisah Ramayana. Dalam pewayangan Jawa, ia digambarkan memiliki "
"sepuluh kepala dan dua puluh tangan. Gambaran tersebut bukan sekadar bentuk fisik, "
"melainkan lambang dari kecerdasan, kekuatan luar biasa, serta hawa nafsu dan ambisi "
"yang tidak terkendali di dalam dirinya. Sebagai penguasa Alengka, Rahwana dikenal "
"mampu memimpin kerajaan besar yang memiliki pasukan raksasa kuat dan disegani banyak negeri.\n\n"

"Kesaktian Rahwana diperoleh melalui tapa brata dan penguasaan berbagai ilmu kanuragan "
"serta ajian tingkat tinggi. Ia memiliki kemampuan berubah rupa, ilmu kekebalan tubuh, "
"dan kekuatan gaib yang membuatnya sangat sulit dikalahkan. Dalam banyak kisah pewayangan, "
"Rahwana juga dikenal mampu menggunakan berbagai senjata pusaka sekaligus dengan dua puluh "
"tangannya. Kekuatan fisik dan kecerdasannya menjadikannya salah satu tokoh paling ditakuti "
"dalam dunia Ramayana.\n\n"

"Di balik sosoknya yang menakutkan, Rahwana sebenarnya juga dikenal sebagai raja yang "
"cerdas dan berwibawa. Ia mampu membawa Alengka menjadi kerajaan besar yang megah dan "
"makmur. Dalam beberapa versi cerita, Rahwana bahkan digambarkan menguasai ilmu sastra, "
"musik, dan spiritualitas. Hal tersebut menunjukkan bahwa dirinya bukan sekadar tokoh "
"jahat biasa, melainkan sosok kompleks yang memiliki kemampuan luar biasa dalam berbagai bidang.\n\n"

"Namun, seluruh kekuatan dan pengetahuan yang dimilikinya perlahan berubah menjadi "
"kesombongan. Rahwana merasa bahwa tidak ada siapa pun yang mampu menandingi dirinya. "
"Keangkuhan itu mencapai puncaknya ketika ia menculik Dewi Sinta, istri Rama, karena "
"terpesona oleh kecantikannya. Tindakan tersebut memicu perang besar antara Kerajaan "
"Alengka melawan Rama dan pasukan wanara yang dipimpin Hanoman.\n\n"

"Dalam peperangan besar itu, Rahwana mengerahkan seluruh kekuatan dan kesaktiannya untuk "
"mempertahankan Alengka. Meski dikenal sangat sakti dan hampir tidak terkalahkan, pada "
"akhirnya ia gugur di tangan Rama. Kekalahan Rahwana menjadi akhir dari kejayaan Alengka "
"dan menjadi simbol runtuhnya kekuasaan yang dibangun di atas kesombongan serta hawa nafsu.\n\n"

"Dalam budaya Jawa dan dunia pewayangan, Rahwana dipandang sebagai lambang angkara murka "
"dan sifat manusia yang dikuasai ambisi duniawi. Kisah hidupnya mengajarkan bahwa kekuatan, "
"ilmu, dan kekuasaan sebesar apa pun tidak akan membawa kemuliaan apabila tidak disertai "
"kebijaksanaan dan pengendalian diri. Dari sosok Rahwana, masyarakat belajar bahwa "
"keserakahan dan kesombongan pada akhirnya hanya akan membawa kehancuran.";

  final String senjataLengkap =
      "Rahwana dikenal sebagai penguasa Alengka yang memiliki kesaktian luar biasa dan menjadi "
      "salah satu tokoh paling kuat dalam kisah Ramayana. Senjata utamanya bukan hanya berupa "
      "senjata fisik, melainkan kekuatan gaib dan ilmu kanuragan tingkat tinggi yang diperoleh "
      "melalui tapa brata serta penguasaan ajian sakti. Ia mampu berubah rupa sesuai kehendaknya, "
      "menghilang dalam sekejap, hingga memiliki ilmu kekebalan tubuh yang membuatnya sangat sulit "
      "dikalahkan di medan perang.\n\n"
      "Dalam berbagai pewayangan Jawa dan naskah Ramayana, Rahwana juga digambarkan mahir "
      "menggunakan beragam senjata pusaka. Dengan dua puluh tangannya, ia dapat memegang dan "
      "mengendalikan banyak senjata sekaligus, mulai dari pedang, gada, tombak, hingga panah sakti. "
      "Kekuatan fisiknya yang besar dipadukan dengan kemampuan strategi perang menjadikannya sosok "
      "raja yang sangat ditakuti oleh lawan-lawannya.\n\n"
      "Selain dikenal sebagai raksasa sakti, Rahwana sebenarnya juga merupakan sosok yang memiliki "
      "pengetahuan luas. Ia digambarkan sebagai pemimpin cerdas yang mampu membangun Kerajaan "
      "Alengka menjadi negeri besar dan makmur. Dalam beberapa versi cerita, Rahwana bahkan dikenal "
      "menguasai ilmu sastra, musik, dan spiritualitas. Hal ini menunjukkan bahwa dirinya bukan "
      "sekadar tokoh antagonis, melainkan figur kompleks yang memiliki kecerdasan, kekuatan, dan "
      "kharisma besar.\n\n"
      "Namun, kekuatan dan pengetahuan yang dimilikinya perlahan berubah menjadi kesombongan. "
      "Rahwana mulai merasa bahwa tidak ada seorang pun yang mampu menandingi dirinya. Ambisi dan "
      "nafsunya untuk memiliki Dewi Sinta menjadi awal kehancuran yang menimpa dirinya dan Kerajaan "
      "Alengka. Dalam peperangan besar melawan Rama, seluruh kesaktian dan kekuatannya akhirnya "
      "tidak mampu menyelamatkannya dari kekalahan.\n\n"
      "Dari sosok Rahwana, masyarakat Jawa dan dunia pewayangan mengambil filosofi bahwa kekuatan "
      "besar harus disertai kebijaksanaan serta pengendalian diri. Kesaktian, kekuasaan, dan ilmu "
      "yang tinggi tidak akan membawa kemuliaan apabila digunakan dengan keserakahan dan keangkuhan. "
      "Rahwana menjadi simbol bahwa manusia yang tidak mampu mengendalikan hawa nafsunya pada "
      "akhirnya akan jatuh oleh kekuatannya sendiri.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ================= APP BAR =================
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

      /// ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),

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
                child: Image.asset('assets/rahwana.png'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "RAHWANA",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: coklatNav,
                letterSpacing: 1.5,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => setState(() => likes++),
                ),
                Text(likes.toString()),
              ],
            ),

            _infoCard(
              title: "Narasi:",
              content:
                  "Rahwana adalah raja Alengka yang terkenal dengan kekuasaan besar sekaligus sifat angkuh...",
              onTap: () => _tampilkanDetail(
                context,
                "Narasi Lengkap Rahwana",
                narasiLengkap,
              ),
            ),

            _infoCard(
              title: "Senjata:",
              content:
                  "Senjata utama Rahwana adalah kesaktian gaibnya yang luar biasa...",
              onTap: () =>
                  _tampilkanDetail(context, "Senjata Rahwana", senjataLengkap),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.white,
        backgroundColor: coklatNav,
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() => _currentIndex = i);

          if (i == 0) {
            Navigator.pop(context);
          } else if (i == 1) {
            Navigator.pop(context);
          } else if (i == 2) {}
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Cari"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }

  /// ================= CARD INFO =================
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
