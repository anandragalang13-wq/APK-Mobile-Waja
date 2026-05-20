import 'package:flutter/material.dart';
import 'baratayuda.dart';

const Color coklat = Color(0xFFBC7647);
const Color bgPage = Color(0xFFFDF8F0);

class CeritaHomePage extends StatelessWidget {
  const CeritaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPage,

      appBar: AppBar(
        backgroundColor: coklat,
        title: const Text('Cerita Pewayangan'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          _ceritaTile(
            context,
            title: 'Baratayuda',
            desc: 'Panah dan Gada',
            image: 'assets/baratayuda.jpg',
          ),

          _ceritaTile(
            context,
            title: 'Ramayana',
            desc: 'Perjalanan Rama dan Sinta',
            image: 'assets/baratayuda.jpg',
          ),

          _ceritaTile(
            context,
            title: 'Wayang Lokal Jawa',
            desc: 'Cerita rakyat dan filosofi Jawa',
            image: 'assets/baratayuda.jpg',
          ),
        ],
      ),
    );
  }

  Widget _ceritaTile(
    BuildContext context, {
    required String title,
    required String desc,
    required String image,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),

      onTap: () {

        if (title == 'Baratayuda') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BaratayudaPage(),
            ),
          );
        }

      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [

            // GAMBAR
            Container(
              width: 70,
              height: 70,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),

              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // TEKS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}