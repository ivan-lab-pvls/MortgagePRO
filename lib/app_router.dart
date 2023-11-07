import 'package:flats/modles/loan.dart';
import 'package:flats/screens/add_loan/add_loan_screen.dart';
import 'package:flats/screens/add_payment/add_payment_screen.dart';
import 'package:flats/screens/i_screen/i_screen.dart';
import 'package:flats/screens/loan_screen/loan_screen.dart';
import 'package:flats/screens/main/main_screen.dart';
import 'package:flats/screens/settings/settings_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String i = '/i';
  static const String main = '/main';
  static const String settigs = '/settings';
  static const String addLoan = '/addLoan';
  static const String loan = '/loan';
  static const String addPayment = '/addPayment';
  static const String lk = '/lk';

  static GoRouter get config => GoRouter(
        initialLocation: i,
        routes: [
          GoRoute(
            path: i,
            name: i,
            builder: (context, state) => const IScreen(),
          ),
          GoRoute(
            path: main,
            name: main,
            builder: (context, state) => const MainScreen(),
          ),
          GoRoute(
            path: loan,
            name: loan,
            builder: (context, state) => LoanScreen(loan: state.extra as Loan),
          ),
          GoRoute(
            path: addPayment,
            name: addPayment,
            builder: (context, state) => const AddPaymentScreen(),
          ),
          GoRoute(
            path: addLoan,
            name: addLoan,
            builder: (context, state) => const AddLoanScreen(),
          ),
          GoRoute(
            path: settigs,
            name: settigs,
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: lk,
            name: lk,
            builder: (context, state) => LKScreen(p: state.extra as String),
          ),
        ],
      );
}
