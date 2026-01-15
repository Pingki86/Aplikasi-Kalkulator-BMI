import 'package:flutter/material.dart';

class TombolReset extends StatelessWidget {
  final VoidCallback onPressed;

  const TombolReset({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.red.shade400,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.red.withOpacity(0.2)),
        ),
        backgroundColor: Colors.red.withOpacity(0.03), // Sedikit tint merah
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.refresh_rounded),
          SizedBox(width: 10),
          Text(
            'Reset Data',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
