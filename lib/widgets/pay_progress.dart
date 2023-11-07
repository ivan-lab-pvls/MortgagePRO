import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flutter/material.dart';

class PayProgress extends StatelessWidget {
  const PayProgress({
    super.key,
    required this.hight,
    required this.loan,
  });

  final double hight;
  final Loan loan;

  @override
  Widget build(BuildContext context) {
    final amount = loan.amount;
    final payed = _getPayedSum();

    final percent = ((payed / amount) * 100).round();

    return Row(
      children: [
        Expanded(
          flex: percent,
          child: Container(
            height: hight,
            color: AppTheme.greenColor,
          ),
        ),
        Expanded(
          flex: 100 - percent,
          child: Container(
            height: hight,
            color: AppTheme.lightColor,
          ),
        ),
      ],
    );
  }

  int _getPayedSum() {
    int payed = 0;
    for (var payment in loan.payments) {
      payed += payment;
    }
    return payed;
  }
}
