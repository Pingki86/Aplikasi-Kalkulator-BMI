import 'package:flutter/material.dart';
import '../validasi/validasi_input.dart';
import '../utilitas/warna_bmi.dart';

class InputUsia extends StatelessWidget {
  final TextEditingController controller;

  const InputUsia({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: (val) => ValidasiInput.validasiAngka(val, 'Usia'),
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      decoration: InputDecoration(
        labelText: 'Usia',
        hintText: '0',
        suffixText: 'thn',
        suffixStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        prefixIcon: const Icon(Icons.cake_outlined),
        filled: true,
        fillColor: WarnaBMI.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: WarnaBMI.normal, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade200, width: 1),
        ),
      ),
    );
  }
}
