class KategoriBMI {
  // Konstanta string agar tidak typo di file lain
  static const String kurus = 'Kurus';
  static const String normal = 'Normal';
  static const String overweight = 'Overweight';
  static const String obesitas = 'Obesitas';

  static String tentukanKategori(double bmi) {
    if (bmi < 18.5) {
      return kurus;
    } else if (bmi < 25) {
      return normal;
    } else if (bmi < 30) {
      return overweight;
    } else {
      return obesitas;
    }
  }
}
