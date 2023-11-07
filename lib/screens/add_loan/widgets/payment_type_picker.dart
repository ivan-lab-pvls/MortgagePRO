import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flutter/material.dart';

class PaymentTypePicker extends StatelessWidget {
  const PaymentTypePicker({
    super.key,
    required this.paymentType,
    required this.onTap,
  });

  final PaymentType paymentType;
  final void Function(PaymentType) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => onTap(PaymentType.annuity),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: paymentType == PaymentType.annuity
                    ? AppTheme.darkColor
                    : null,
                borderRadius: BorderRadius.circular(8),
                border: paymentType == PaymentType.annuity
                    ? Border.all(color: AppTheme.lightColor)
                    : null,
              ),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'ANNUITY',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InkWell(
            onTap: () => onTap(PaymentType.differential),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: paymentType == PaymentType.differential
                    ? AppTheme.darkColor
                    : null,
                borderRadius: BorderRadius.circular(8),
                border: paymentType == PaymentType.differential
                    ? Border.all(color: AppTheme.lightColor)
                    : null,
              ),
              padding: const EdgeInsets.all(10),
              child: const Text(
                'DIFFERENTIAL',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
