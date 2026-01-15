import 'package:flutter/material.dart';
import '../utilitas/warna_bmi.dart';

class IndikatorBMI extends StatelessWidget {
  final double bmi;

  const IndikatorBMI({super.key, required this.bmi});

  @override
  Widget build(BuildContext context) {
    // Definisi range (harus sinkron antara slider dan visual warna)
    const double minBMI = 15.0;
    const double maxBMI = 40.0;

    // Normalisasi posisi jarum (0.0 s/d 1.0)
    double normalizedPosition = ((bmi - minBMI) / (maxBMI - minBMI)).clamp(
      0.0,
      1.0,
    );

    // Konversi ke koordinat Alignment (-1.0 s/d 1.0)
    double alignX = (normalizedPosition * 2) - 1;

    // Fungsi helper untuk menghitung posisi label angka agar pas dengan warna
    // Contoh: Batas 25 ada di (25-15)/(40-15) = 0.4 (40% dari kiri)
    Alignment getAlignForValue(double val) {
      double pos = ((val - minBMI) / (maxBMI - minBMI)).clamp(0.0, 1.0);
      return Alignment((pos * 2) - 1, 0);
    }

    return Column(
      children: [
        // Header Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Skala BMI",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Nilai Anda: ",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                children: [
                  TextSpan(
                    text: bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: WarnaBMI.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // AREA DIAGRAM (Stack)
        SizedBox(
          height: 60,
          child: Stack(
            clipBehavior:
                Clip.none, // Agar label bisa sedikit keluar jika perlu
            alignment: Alignment.center,
            children: [
              // 1. Bar Gradient
              Container(
                height: 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [
                      WarnaBMI.kurus,
                      WarnaBMI.kurus,
                      WarnaBMI.normal,
                      WarnaBMI.normal,
                      WarnaBMI.gemuk,
                      WarnaBMI.gemuk,
                      WarnaBMI.obesitas,
                    ],
                    // Stop point dihitung matematis:
                    // 18.5 -> 0.14
                    // 25.0 -> 0.40
                    // 30.0 -> 0.60
                    stops: [0.0, 0.14, 0.14, 0.40, 0.40, 0.60, 1.0],
                  ),
                ),
              ),

              // 2. Garis Pembatas Putih (Separator)
              Align(alignment: getAlignForValue(18.5), child: _separator()),
              Align(alignment: getAlignForValue(25.0), child: _separator()),
              Align(alignment: getAlignForValue(30.0), child: _separator()),

              // 3. Label Angka (Diposisikan Akurat dengan Align)
              // Menggunakan Transform.translate untuk menggeser teks agar 'center' nya pas di titik
              Align(
                alignment: getAlignForValue(15.0),
                child: _labelAngka("15", kiri: true),
              ),
              Align(
                alignment: getAlignForValue(18.5),
                child: _labelAngka("18.5"),
              ),
              Align(
                alignment: getAlignForValue(25.0),
                child: _labelAngka("25"),
              ),
              Align(
                alignment: getAlignForValue(30.0),
                child: _labelAngka("30"),
              ),
              Align(
                alignment: getAlignForValue(40.0),
                child: _labelAngka("40", kanan: true),
              ),

              // 4. Pointer Jarum (Animated)
              AnimatedAlign(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutBack,
                alignment: Alignment(alignX, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Lingkaran luar putih (border)
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      // Lingkaran dalam berwarna
                      child: Center(
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: _getWarnaByBMI(bmi),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Legenda Kategori
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _legendItem("Kurus", WarnaBMI.kurus),
            _legendItem("Normal", WarnaBMI.normal),
            _legendItem("Gemuk", WarnaBMI.gemuk),
            _legendItem("Obesitas", WarnaBMI.obesitas),
          ],
        ),
      ],
    );
  }

  // Widget kecil untuk garis pemisah putih
  Widget _separator() {
    return Container(
      width: 2,
      height: 12,
      color: Colors.white.withOpacity(0.8),
    );
  }

  // Widget label angka di bawah bar
  Widget _labelAngka(String text, {bool kiri = false, bool kanan = false}) {
    return Transform.translate(
      // Geser sedikit ke bawah agar tidak menumpuk garis
      offset: const Offset(0, 22),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        // Logika agar teks paling kiri tidak terpotong layar
        textAlign: kiri
            ? TextAlign.left
            : (kanan ? TextAlign.right : TextAlign.center),
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
        ),
      ],
    );
  }

  Color _getWarnaByBMI(double bmi) {
    if (bmi < 18.5) return WarnaBMI.kurus;
    if (bmi >= 18.5 && bmi < 25) return WarnaBMI.normal;
    if (bmi >= 25 && bmi < 30) return WarnaBMI.gemuk;
    return WarnaBMI.obesitas;
  }
}
