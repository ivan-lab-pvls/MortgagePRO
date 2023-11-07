import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flats/app_router.dart';
import 'package:flats/main.dart';
import 'package:flats/screens/i_screen/widgets/on_boarding_screen.dart';
import 'package:flats/screens/i_screen/widgets/privacy_policy_screen.dart';
import 'package:flats/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IScreen extends StatefulWidget {
  const IScreen({super.key});

  @override
  State<IScreen> createState() => _IScreenState();
}

class _IScreenState extends State<IScreen> {
  late final SharedPreferences _shPref;
  bool _pageInited = false;
  bool khl = false;
  String mNews = '';

  @override
  void initState() {
    super.initState();

    _shPref = context.read<SharedPreferences>();
    _pr();
  }

  void _pr() async {
    rate(_shPref);
    await Future.delayed(const Duration(seconds: 0));

    final news = FirebaseRemoteConfig.instance.getString('mortgage');
    if (!news.contains('isPrivacy')) {
      setState(() {
        mNews = news;
        khl = true;
      });
      return;
    }

    final onBoarding = _shPref.getBool('onBoarding') ?? false;

    if (!onBoarding) {
      setState(() {
        _pageInited = true;
      });
      return;
    }

    context.go(AppRouter.main);
  }

  @override
  Widget build(BuildContext context) {
    if (khl) return PrivacyPolicyScreen(trink: mNews);
    return _pageInited
        ? const OnBoardingScreen()
        : Scaffold(
            body: Center(
              child: Image.asset(
                'assets/money_bag.png',
                height: 120,
                width: 120,
              ),
            ),
          );
  }
}
