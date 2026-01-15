import 'package:flutter/material.dart';
import '../utilitas/warna_bmi.dart';

class PilihanJenisKelamin extends StatefulWidget {
  final String? jenisKelamin;
  final Function(String?) onChanged;

  const PilihanJenisKelamin({
    super.key,
    required this.jenisKelamin,
    required this.onChanged,
  });

  @override
  State<PilihanJenisKelamin> createState() => _PilihanJenisKelaminState();
}

class _PilihanJenisKelaminState extends State<PilihanJenisKelamin> {
  String? get _value => widget.jenisKelamin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Kelamin',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: WarnaBMI.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildCard(
              label: 'Laki-laki',
              icon: Icons.male,
              value: 'Laki-laki',
              active: _value == 'Laki-laki',
              color: const Color(0xFF42A5F5), // Biru Spesifik
            ),
            const SizedBox(width: 16),
            _buildCard(
              label: 'Perempuan',
              icon: Icons.female,
              value: 'Perempuan',
              active: _value == 'Perempuan',
              color: const Color(0xFFEC407A), // Pink Spesifik
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({
    required String label,
    required IconData icon,
    required String value,
    required bool active,
    required Color color,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          decoration: BoxDecoration(
            // Logic warna background saat aktif
            color: active ? color.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: active ? color : Colors.grey.shade200,
              width: active ? 2 : 1.5,
            ),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
                color: active ? color : Colors.grey.shade400,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: active ? color : Colors.grey.shade600,
                ),
              ),
              if (active) ...[
                const SizedBox(height: 4),
                Icon(Icons.check_circle, size: 16, color: color),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
