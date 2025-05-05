import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isCancel;
//ignore
  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isCancel 
            ? Colors.grey[100] 
            : theme.colorScheme.primary,
        foregroundColor: isCancel 
            ? theme.colorScheme.primary 
            : Colors.white,
        elevation: isCancel ? 0 : 1,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: isCancel
              ? BorderSide(color: theme.colorScheme.tertiary)
              : BorderSide.none,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isCancel ? FontWeight.w500 : FontWeight.w600, 
          fontSize: 14,
        ),
      ),
    );
  }
}