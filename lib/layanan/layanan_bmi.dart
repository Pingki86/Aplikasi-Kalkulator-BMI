import '../model/data_hasil_bmi.dart';

class LayananBMI {
  static DataHasilBMI hitungBMI({
    required double berat,
    required double tinggi,
  }) {
    final tinggiMeter = tinggi / 100;
    final bmi = berat / (tinggiMeter * tinggiMeter);

    String kategori;
    List<String> saran;

    if (bmi < 18.5) {
      kategori = 'Kurus';
      saran = [
        'Perbanyak asupan kalori sehat',
        'Konsumsi protein tinggi',
        'Olahraga ringan secara rutin',
      ];
    } else if (bmi < 25) {
      kategori = 'Normal';
      saran = [
        'Pertahankan pola makan seimbang',
        'Rutin berolahraga',
        'Cukup istirahat',
      ];
    } else if (bmi < 30) {
      kategori = 'Overweight';
      saran = [
        'Kurangi makanan berlemak',
        'Perbanyak sayur dan buah',
        'Olahraga kardio',
      ];
    } else {
      kategori = 'Obesitas';
      saran = [
        'Konsultasi dengan tenaga kesehatan',
        'Atur pola makan ketat',
        'Olahraga teratur dan terkontrol',
      ];
    }

    return DataHasilBMI(nilaiBMI: bmi, kategori: kategori, saran: saran);
  }
}
