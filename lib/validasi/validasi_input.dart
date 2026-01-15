class ValidasiInput {
  static String? validasiKosong(String? value, String namaField) {
    if (value == null || value.trim().isEmpty) {
      return '$namaField wajib diisi';
    }
    return null;
  }

  static String? validasiAngka(String? value, String namaField) {
    if (value == null || value.trim().isEmpty) {
      return '$namaField wajib diisi';
    }

    // Mengganti koma dengan titik untuk support format Indonesia
    final normalizedValue = value.replaceAll(',', '.');
    final angka = double.tryParse(normalizedValue);

    if (angka == null) {
      return '$namaField harus berupa angka valid';
    }

    if (angka <= 0) {
      return '$namaField tidak boleh 0 atau minus';
    }

    // Validasi batas wajar manusia (UX: Mencegah input typo seperti 2000 cm)
    if (namaField.toLowerCase().contains('tinggi') && angka > 300) {
      return '$namaField tidak wajar (maks 300cm)';
    }
    if (namaField.toLowerCase().contains('berat') && angka > 500) {
      return '$namaField tidak wajar';
    }

    return null;
  }
}
