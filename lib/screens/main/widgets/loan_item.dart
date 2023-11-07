import 'package:flats/app_router.dart';
import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flats/screens/main/widgets/loan_item_property.dart';
import 'package:flats/widgets/pay_progress.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class LoanItem extends StatelessWidget {
  const LoanItem({
    super.key,
    required this.loan,
  });

  final Loan loan;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => context.push(AppRouter.loan,extra: loan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.lightColor),
          color: AppTheme.darkColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loan.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppTheme.greenColor,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                LoanItemProperty(
                  title: 'Amount',
                  value: '${loan.amount} \$',
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  height: 16,
                  width: 1,
                  color: AppTheme.lightColor,
                ),
                LoanItemProperty(
                  title: 'Rate',
                  value: '${loan.rate} %',
                ),
                Container(
                  height: 16,
                  width: 1,
                  color: AppTheme.lightColor,
                ),
                LoanItemProperty(
                  title: 'Issue date',
                  value: DateFormat('dd.MM.yyyy').format(loan.firstPaymentDate),
                  alignment: Alignment.centerRight,
                ),
              ],
            ),
            const SizedBox(height: 24),
            PayProgress(
              hight: 4,
              loan: loan,
            ),
          ],
        ),
      ),
    );
  }
}
