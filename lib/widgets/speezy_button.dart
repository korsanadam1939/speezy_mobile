import 'package:flutter/material.dart';

class SpeezyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;
  final double borderRadius;
  final bool isExpanded;


  const SpeezyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.color,
    this.textColor,
    this.padding,
    this.borderRadius = 12,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, color: textColor),
        if (icon != null) const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );

    final button = ElevatedButton(

      style: ElevatedButton.styleFrom(

        backgroundColor: color ?? Theme.of(context).primaryColor,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );

    return isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
