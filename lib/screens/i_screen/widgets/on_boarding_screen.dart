import 'package:flats/app_router.dart';
import 'package:flats/screens/i_screen/widgets/first_on_boarding_body.dart';
import 'package:flats/screens/i_screen/widgets/second_on_boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final SharedPreferences _shPref;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _shPref = context.read<SharedPreferences>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _controller,
          children: [
            FirstOnBoardingBody(
              onTap: () => _controller.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.linear,
              ),
            ),
            SecondOnBoardingBody(
              onTap: () async {
                await _shPref.setBool('onBoarding', true);
                context.go(AppRouter.main);
              },
            ),
          ],
        ),
      ),
    );
  }
}
