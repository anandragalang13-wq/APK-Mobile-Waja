import 'package:flutter/material.dart';

const Color coklat = Color(0xFFBC7647);
const Color bgPage = Color(0xFFFDF8F0);

class BaratayudaPage extends StatefulWidget {
  const BaratayudaPage({super.key});

  @override
  State<BaratayudaPage> createState() => _BaratayudaPageState();
}

class _BaratayudaPageState extends State<BaratayudaPage> {
  bool isLiked = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPage,
      appBar: AppBar(
        backgroundColor: coklat,
        title: const Text('Baratayuda'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              setState(() => isLiked = !isLiked);
            },
          ),
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              setState(() => isSaved = !isSaved);
            },
          ),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          """ Perang Baratayudha bermula dari satu akar yang sederhana namun pahit: keserakahan dan ketidakadilan. Di Kerajaan Hastinapura, dua wangsa keturunan Raja Bharata—Pandawa dan Kurawa—tumbuh bersama sebagai saudara, tetapi tak pernah benar-benar setara. Pandawa dikenal jujur dan menjunjung dharma, sementara Kurawa, dipimpin oleh Duryodana, dikuasai iri dan ambisi akan kekuasaan.

Sejak muda, Pandawa terus disingkirkan. Mereka ditipu dalam permainan dadu, kehilangan kerajaan, dan diasingkan ke hutan selama bertahun-tahun. Meski demikian, mereka tetap menepati janji dan tidak membalas dengan dendam. Ketika masa pengasingan berakhir, Pandawa hanya meminta kembali hak mereka—bahkan sebatas lima desa—namun Duryodana menolak dengan angkuh. Saat itulah perang tak lagi bisa dihindari.

Medan Kurukshetra menjadi saksi berkumpulnya para ksatria terbesar dari kedua pihak. Saudara berhadapan dengan saudara, murid melawan guru, murid panah melawan sahabat lama. Sebelum perang dimulai, Arjuna dilanda keraguan melihat kerabat dan gurunya berdiri sebagai musuh. Di saat itulah Kresna menurunkan ajaran suci tentang kewajiban, ketulusan, dan dharma—ajaran yang kelak dikenal sebagai Bhagavad Gita.

Perang berlangsung selama delapan belas hari, dan setiap hari membawa kehilangan. Bhisma, ksatria agung yang hampir tak terkalahkan, akhirnya tumbang bukan karena lemah, tetapi karena sumpahnya sendiri. Drona, guru para Pandawa dan Kurawa, gugur setelah hatinya dipatahkan oleh kabar palsu tentang anaknya. Karna, pahlawan besar yang setia pada Duryodana meski hidupnya penuh penolakan, mati di tangan Arjuna saat keretanya terperosok—sebuah akhir tragis bagi ksatria berhati mulia.

Salah satu peristiwa paling memilukan adalah gugurnya Abimanyu, putra Arjuna, yang masih sangat muda. Ia menembus formasi perang musuh dengan keberanian luar biasa, tetapi dikepung dan dibunuh secara tidak adil. Kematian Abimanyu mengubah perang menjadi lebih gelap, penuh sumpah balas dendam dan amarah yang sulit dibendung.

Menjelang akhir perang, Kurawa satu per satu gugur. Duryodana akhirnya dikalahkan oleh Bima dalam pertarungan gada. Namun bahkan setelah kemenangan diraih, malam membawa kengerian lain: Aswatthama, putra Drona, menyerang perkemahan Pandawa dan membantai para prajurit yang tersisa. Kemenangan pun terasa pahit dan hampa.

Ketika perang berakhir, Pandawa menang—tetapi hampir tak ada yang benar-benar bahagia. Kerajaan memang kembali ke tangan mereka, namun dunia telah berubah. Keluarga hancur, sahabat tiada, dan tanah Kurukshetra basah oleh air mata lebih dari darah.

Perang Baratayudha bukan kisah tentang kemenangan mutlak, melainkan pengingat bahwa bahkan perang demi kebenaran tetap membawa penderitaan. Ia mengajarkan bahwa dharma harus ditegakkan, tetapi setiap pilihan memiliki harga. Dan sering kali, yang tersisa setelah perang bukanlah kejayaan—melainkan keheningan dan penyesalan.""",
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
    );
  }
}