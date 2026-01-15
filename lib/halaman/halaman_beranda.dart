import 'package:flutter/material.dart';
import '../layanan/layanan_bmi.dart';
import '../halaman/halaman_hasil.dart';
import '../utilitas/warna_bmi.dart';
// Import Widget Custom yang sudah dibuat
import '../widget/pilihan_jenis_kelamin.dart';
import '../widget/input_berat_badan.dart';
import '../widget/input_tinggi_badan.dart';
import '../widget/input_usia.dart';
import '../widget/tombol_hitung.dart';
import '../widget/tombol_reset.dart';

class HalamanBeranda extends StatefulWidget {
  const HalamanBeranda({super.key});

  @override
  State<HalamanBeranda> createState() => _HalamanBerandaState();
}

class _HalamanBerandaState extends State<HalamanBeranda> {
  // Key untuk Validasi Form Otomatis
  final _formKey = GlobalKey<FormState>();

  final _beratController = TextEditingController();
  final _tinggiController = TextEditingController();
  final _usiaController = TextEditingController();

  String _jenisKelamin = 'Laki-laki';

  @override
  void dispose() {
    _beratController.dispose();
    _tinggiController.dispose();
    _usiaController.dispose();
    super.dispose();
  }

  void _reset() {
    _beratController.clear();
    _tinggiController.clear();
    _usiaController.clear();
    setState(() {
      _jenisKelamin = 'Laki-laki';
    });
    // Hilangkan fokus keyboard
    FocusScope.of(context).unfocus();
  }

  void _hitungBMI() {
    // 1. Jalankan Validasi Form (Cek kosong/angka/minus)
    if (_formKey.currentState!.validate()) {
      // 2. Jika valid, ambil data
      // replaceAll untuk menangani input user yang pakai koma (cth: 60,5)
      final berat = double.parse(_beratController.text.replaceAll(',', '.'));
      final tinggi = double.parse(_tinggiController.text.replaceAll(',', '.'));

      // 3. Panggil Logic Bisnis
      final hasil = LayananBMI.hitungBMI(berat: berat, tinggi: tinggi);

      // 4. Navigasi (Hilangkan keyboard dulu)
      FocusScope.of(context).unfocus();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HalamanHasil(hasil: hasil)),
      );
    } else {
      // UX: Beri feedback getar atau snackbar jika ada error (opsional)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Mohon lengkapi data dengan benar'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // UX: Tap di luar form akan menutup keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: WarnaBMI.background,
        appBar: AppBar(
          title: const Text('Kalkulator BMI'),
          backgroundColor: Colors.transparent, // Menyatu dengan background
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Teks
              const Text(
                "Cek Kesehatanmu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: WarnaBMI.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lengkapi data berikut untuk mengetahui indeks massa tubuh Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Kartu Form Utama
              Card(
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.05),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey, // Bind Key Form di sini
                    child: Column(
                      children: [
                        // Widget Jenis Kelamin
                        PilihanJenisKelamin(
                          jenisKelamin: _jenisKelamin,
                          onChanged: (val) {
                            if (val != null)
                              setState(() => _jenisKelamin = val);
                          },
                        ),

                        const Divider(height: 32, color: WarnaBMI.background),

                        // Widget Input Custom
                        InputUsia(controller: _usiaController),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: InputBeratBadan(
                                controller: _beratController,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: InputTinggiBadan(
                                controller: _tinggiController,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Tombol Aksi
                        TombolHitung(onPressed: _hitungBMI),
                        const SizedBox(height: 12),
                        TombolReset(onPressed: _reset),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Bagian Tips (Info Card)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: WarnaBMI.normal.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: WarnaBMI.normal.withOpacity(0.3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.lightbulb_outline, color: WarnaBMI.normal),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Tips Pengukuran",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: WarnaBMI.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Pastikan tinggi dalam cm (contoh: 170) dan berat dalam kg (contoh: 65.5).",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
