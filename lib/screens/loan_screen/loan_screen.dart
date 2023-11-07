import 'package:flats/app_router.dart';
import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flats/modles/loans_change_notifier.dart';
import 'package:flats/screens/loan_screen/widgets/loan_option.dart';
import 'package:flats/screens/loan_screen/widgets/payed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoanScreen extends StatefulWidget {
  const LoanScreen({super.key, required this.loan});
  final Loan loan;

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  late final LoansChangeNotifier _loansChangeNotifier;
  late Loan _edittedLoan;

  @override
  void initState() {
    super.initState();
    _loansChangeNotifier = context.read<LoansChangeNotifier>();
    _edittedLoan = widget.loan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).primaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset('assets/arrow_back.svg'),
                  ),
                  const Text(
                    'LOAN INFO',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () => context.push(AppRouter.settigs),
                    child: SvgPicture.asset('assets/gear.svg'),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        LoanOption(
                          iconPath: 'assets/plus_circle.svg',
                          textColor: AppTheme.greenColor,
                          title: 'ADD PAYMENT',
                          onTap: () async {
                            final newPayment =
                                await context.push<int?>(AppRouter.addPayment);
                            if (newPayment == null) return;
                            final newPayments = [
                              ..._edittedLoan.payments.toList(),
                              newPayment
                            ];
                            setState(() {
                              _edittedLoan =
                                  _edittedLoan.copyWith(payments: newPayments);
                            });
                          },
                        ),
                        const SizedBox(width: 4),
                        const LoanOption(
                          iconPath: 'assets/schedule.svg',
                          textColor: Colors.white,
                          title: 'SCHEDULE',
                        ),
                        const SizedBox(width: 4),
                        const LoanOption(
                          iconPath: 'assets/chat.svg',
                          textColor: Colors.white,
                          title: 'DETAILS',
                        ),
                      ],
                    ),
                    const Divider(
                      height: 64,
                      color: AppTheme.lightColor,
                    ),
                    PayedWidget(loan: _edittedLoan),
                    const Divider(
                      height: 64,
                      color: AppTheme.lightColor,
                    ),
                    if (_edittedLoan.payments.isNotEmpty) ...[
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Current payment',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${_edittedLoan.payments.last}\$',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 64,
                        color: AppTheme.lightColor,
                      ),
                    ],
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Paid interest',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Remaining interest',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '156\$',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total interest',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '156\$',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 64,
                      color: AppTheme.lightColor,
                    ),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total Fee',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total insurance',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 64,
                      color: AppTheme.lightColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  _loansChangeNotifier.deleteLoan(widget.loan);
                  context.pop();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppTheme.lightColor),
                    color: AppTheme.darkColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'DELETE LOAN',
                    style: TextStyle(
                      color: Color(0xFFC62424),
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  _loansChangeNotifier.editLoan(widget.loan, _edittedLoan);
                  context.pop();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppTheme.lightColor),
                    color: AppTheme.darkColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'EDIT LOAN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
