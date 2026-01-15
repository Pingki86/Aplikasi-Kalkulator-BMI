import 'package:flutter/material.dart';
import '../model/data_hasil_bmi.dart';
import '../utilitas/kategori_bmi.dart';
import '../indikator/indikator_bmi.dart';
import '../utilitas/warna_bmi.dart';

class HalamanHasil extends StatelessWidget {
  final DataHasilBMI hasil;

  const HalamanHasil({super.key, required this.hasil});

  Color _getWarnaKategori(String kategori) {
    switch (kategori) {
      case KategoriBMI.kurus:
        return WarnaBMI.kurus;
      case KategoriBMI.normal:
        return WarnaBMI.normal;
      case KategoriBMI.overweight:
        return WarnaBMI.gemuk;
      case KategoriBMI.obesitas:
        return WarnaBMI.obesitas;
      default:
        return WarnaBMI.obesitas;
    }
  }

  @override
  Widget build(BuildContext context) {
    final warnaTema = _getWarnaKategori(hasil.kategori);

    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih
      appBar: AppBar(
        title: const Text('Analisa Kesehatan'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: WarnaBMI.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: const TextStyle(
          color: WarnaBMI.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Hasil BMI Anda",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 1. Angka Besar
                  Text(
                    hasil.nilaiBMI.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 80, // Lebih besar agar jadi focal point
                      fontWeight: FontWeight.w900,
                      color: warnaTema,
                      height: 1.0,
                    ),
                  ),

                  // 2. Badge Kategori
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: warnaTema.withOpacity(
                        0.1,
                      ), // Opacity lebih tipis agar elegan
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      hasil.kategori.toUpperCase(),
                      style: TextStyle(
                        color: warnaTema,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 3. Diagram Indikator (Card Style)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      // Shadow lembut seperti di desain
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: IndikatorBMI(bmi: hasil.nilaiBMI),
                  ),

                  const SizedBox(height: 40),

                  // 4. Rekomendasi
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.verified_user_outlined,
                          color: WarnaBMI.textPrimary,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Rekomendasi Kesehatan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: WarnaBMI.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  ...hasil.saran.map((saran) => _buildSaranItem(saran)),

                  // Spacer agar konten tidak terpotong tombol di bawah
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 5. Area Tombol di bagian bawah (Fixed)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: warnaTema,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor: warnaTema.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Hitung Ulang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaranItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFE8F5E9), // Hijau sangat muda
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 16, color: Color(0xFF2E7D32)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
