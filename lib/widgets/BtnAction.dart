import 'package:flutter/material.dart';

class BtnAction extends StatelessWidget {
  final String label;
  final VoidCallback onCancel;
  final VoidCallback onPressed;

  const BtnAction({
    super.key,
    required this.label,
    required this.onCancel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: onCancel,
          child: const Text(
            "Annuler",
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text( // ❌ plus const ici
            label,
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}