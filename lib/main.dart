import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flats/app_router.dart';
import 'package:flats/app_theme.dart';
import 'package:flats/config.dart';
import 'package:flats/modles/loans_change_notifier.dart';
import 'package:flats/notifx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 1),
    minimumFetchInterval: const Duration(seconds: 1),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationServiceFb().activate();

  final shPref = await SharedPreferences.getInstance();

  runApp(MyApp(shPref: shPref));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.shPref,
  });

  final SharedPreferences shPref;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoansChangeNotifier(shPref)..init(),
        ),
        Provider.value(value: shPref),
      ],
      child: MaterialApp.router(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.config,
      ),
    );
  }
}
