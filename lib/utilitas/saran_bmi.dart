import '../utilitas/kategori_bmi.dart';

class SaranBMI {
  static List<String> dapatkanSaran(String kategori) {
    switch (kategori) {
      case KategoriBMI.kurus:
        return [
          'Tingkatkan asupan kalori dengan makanan padat gizi (kacang-kacangan, alpukat, susu).',
          'Fokus pada latihan beban untuk membangun massa otot, bukan hanya lemak.',
          'Makan lebih sering dengan porsi kecil (5-6 kali sehari).',
          'Pastikan asupan protein cukup di setiap makan.',
        ];
      case KategoriBMI.normal:
        return [
          'Pertahankan pola makan seimbang (karbohidrat kompleks, protein, lemak sehat).',
          'Lakukan aktivitas fisik rutin minimal 150 menit per minggu.',
          'Jaga hidrasi tubuh dengan minum air putih yang cukup.',
          'Istirahat yang cukup (7-8 jam) untuk pemulihan tubuh optimal.',
        ];
      case KategoriBMI.overweight:
        return [
          'Kurangi konsumsi gula tambahan dan makanan olahan.',
          'Perbanyak porsi sayuran dan serat di setiap piring makan.',
          'Lakukan kombinasi olahraga kardio (jalan cepat, renang) dan angkat beban.',
          'Hindari makan larut malam dan perhatikan porsi makan.',
        ];
      case KategoriBMI.obesitas:
        return [
          'Konsultasikan dengan dokter atau ahli gizi untuk rencana penurunan berat badan yang aman.',
          'Mulai dengan aktivitas fisik ringan seperti berjalan kaki 30 menit setiap hari.',
          'Fokus pada makanan utuh (whole foods) dan hindari makanan cepat saji.',
          'Catat asupan makan harian untuk memonitor kalori yang masuk.',
        ];
      default:
        return ['Tetap jaga pola hidup sehat.', 'Rutin berolahraga.'];
    }
  }
}
