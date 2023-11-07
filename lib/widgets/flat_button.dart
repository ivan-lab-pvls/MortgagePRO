import 'package:flats/app_theme.dart';
import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  const FlatButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AppTheme.greenColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
