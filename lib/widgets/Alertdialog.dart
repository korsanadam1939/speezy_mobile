import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,color: Colors.redAccent,size: 50,),
          Text(content),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text("Tamam"),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
