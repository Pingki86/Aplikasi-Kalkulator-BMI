import 'package:flutter/material.dart';
import '../utilitas/warna_bmi.dart';

class TombolHitung extends StatelessWidget {
  final VoidCallback onPressed;

  const TombolHitung({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            WarnaBMI.textPrimary, // Menggunakan warna gelap utama agar elegan
        foregroundColor: Colors.white,
        elevation: 8,
        shadowColor: WarnaBMI.textPrimary.withOpacity(0.3),
        minimumSize: const Size(double.infinity, 56), // Sedikit lebih tinggi
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Hitung BMI',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded),
        ],
      ),
    );
  }
}
