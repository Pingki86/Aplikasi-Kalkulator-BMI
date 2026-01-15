import 'package:flutter/material.dart';
import 'kategori_bmi.dart';

class WarnaBMI {
  // Warna Utama
  static const Color background = Color(0xFFF4F6F8); // Abu sangat muda
  static const Color textPrimary = Color(0xFF2D3436); // Hitam lembut

  // Warna Kategori
  static const Color kurus = Color(0xFF4FC3F7); // Biru Langit
  static const Color normal = Color(0xFF66BB6A); // Hijau Segar
  static const Color gemuk = Color(0xFFFFA726); // Oranye
  static const Color obesitas = Color(0xFFEF5350); // Merah Soft

  static Color getWarna(String kategori) {
    switch (kategori) {
      case KategoriBMI.kurus:
        return kurus;
      case KategoriBMI.normal:
        return normal;
      case KategoriBMI.overweight:
        return gemuk;
      case KategoriBMI.obesitas:
        return obesitas;
      default:
        return obesitas;
    }
  }
}
