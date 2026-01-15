import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahan untuk mengatur status bar
import 'halaman/halaman_beranda.dart';
import 'utilitas/warna_bmi.dart'; // Pastikan import ini ada

void main() {
  // Memastikan binding terinisialisasi sebelum mengatur SystemChrome
  WidgetsFlutterBinding.ensureInitialized();

  // UX: Membuat Status Bar transparan agar aplikasi terlihat full screen & modern
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // Ikon status bar gelap
    ),
  );

  runApp(const AplikasiBMI());
}

class AplikasiBMI extends StatelessWidget {
  const AplikasiBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator BMI',
      theme: ThemeData(
        useMaterial3: true,

        // Menggunakan Warna Normal (Hijau) sebagai seed utama
        colorSchemeSeed: WarnaBMI.normal,

        // Background global aplikasi yang lembut (abu-abu sangat muda)
        // Ini kunci agar card putih terlihat kontras dan elegan ('pop out')
        scaffoldBackgroundColor: WarnaBMI.background,

        // Font default aplikasi
        fontFamily:
            'Roboto', // Bisa diganti 'Poppins' jika sudah menambahkan font
        // Konfigurasi AppBar Global yang bersih
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, // Atau Colors.white
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            color: WarnaBMI.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: WarnaBMI.textPrimary),
        ),

        // Konfigurasi Input Global (Fallback jika widget tidak mendefinisikan sendiri)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: WarnaBMI.normal, width: 2),
          ),
        ),

        // Konfigurasi Tombol Global
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: WarnaBMI.textPrimary,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            minimumSize: const Size(double.infinity, 56),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const HalamanBeranda(),
    );
  }
}
