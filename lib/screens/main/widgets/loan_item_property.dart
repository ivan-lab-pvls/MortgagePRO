import 'package:flats/app_theme.dart';
import 'package:flutter/material.dart';

class LoanItemProperty extends StatelessWidget {
  const LoanItemProperty({
    super.key,
    required this.title,
    required this.value,
    this.alignment = Alignment.center,
  });
  final Alignment alignment;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.lightColor,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}