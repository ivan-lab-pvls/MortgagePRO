import 'package:flats/app_router.dart';
import 'package:flats/app_theme.dart';
import 'package:flats/modles/loan.dart';
import 'package:flats/modles/loans_change_notifier.dart';
import 'package:flats/screens/main/widgets/loan_item.dart';
import 'package:flats/widgets/flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final LoansChangeNotifier _loansChangeNotifier;

  @override
  void initState() {
    super.initState();
    _loansChangeNotifier = context.read<LoansChangeNotifier>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
            listenable: _loansChangeNotifier,
            builder: (context, child) {
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                    title: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'WELCOME',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () => context.push(AppRouter.settigs),
                            child: SvgPicture.asset('assets/gear.svg')),
                      ],
                    ),
                  ),
                  _loansChangeNotifier.loans.isEmpty
                      ? const SliverFillRemaining(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "IT'S EMPTY",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Add information about your mortgage by clicking the "Add Loan" button',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppTheme.lightColor,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16,
                          ),
                          sliver: SliverList.builder(
                            itemCount: _loansChangeNotifier.loans.length,
                            itemBuilder: (context, index) {
                              final loan = _loansChangeNotifier.loans[index];

                              return LoanItem(loan: loan);
                            },
                          ),
                        ),
                ],
              );
            }),
      ),
      floatingActionButton: FlatButton(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 50,
        onTap: () => _onAddLoanTap(context),
        text: 'ADD LOAN',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onAddLoanTap(BuildContext context) async {
    final result = await context.push<Loan?>(AppRouter.addLoan);
    if (result == null) return;
    _loansChangeNotifier.addLoan(result);
  }
}
