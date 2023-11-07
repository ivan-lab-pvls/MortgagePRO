import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flats/widgets/pay_progress.dart';
import 'package:flutter/material.dart';

class PayedWidget extends StatelessWidget {
  const PayedWidget({
    super.key,
    required this.loan,
  });

  final Loan loan;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_getPayedSumm()}\$',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Text(
              '${loan.amount}\$',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        PayProgress(
          hight: 6,
          loan: loan,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paid',
              style: TextStyle(
                color: AppTheme.lightColor,
                fontSize: 11,
              ),
            ),
            Text(
              'Debt',
              style: TextStyle(
                color: AppTheme.lightColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int _getPayedSumm() {
    int payed = 0;

    for (var payment in loan.payments) {
      payed += payment;
    }
    return payed;
  }
}
