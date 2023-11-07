import 'package:flats/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'SETTINGS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _SettingTile(
                title: 'Privacy Policy',
                onTap: () => context.push(AppRouter.lk,
                    extra:
                        'https://docs.google.com/document/d/1HxulcD1gNQm0XXmUVFzk-_CAdDlofzbJE9IcXswHt1o/edit?usp=sharing'),
              ),
              _SettingTile(
                title: 'Terms and Condition',
                onTap: () => context.push(AppRouter.lk,
                    extra:
                        'https://docs.google.com/document/d/14H1luNmj23rQ3jyUepgO_lP_rJh8FoTqkszm_4l5Wp0/edit?usp=sharing'),
              ),
              _SettingTile(
                title: 'Write Support',
                onTap: () => context.push(AppRouter.lk,
                    extra: 'https://forms.gle/GQKLramC4sTWUxxi8'),
              ),
              _SettingTile(
                title: 'Rate our app in the AppStore',
                onTap: () => InAppReview.instance
                    .openStoreListing(appStoreId: '6471505545'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LKScreen extends StatefulWidget {
  const LKScreen({super.key, required this.p});
  final String p;

  @override
  State<LKScreen> createState() => _LKScreenState();
}

class _LKScreenState extends State<LKScreen> {
  var _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            InAppWebView(
              onLoadStop: (controller, url) {
                controller.evaluateJavascript(
                    source:
                        "javascript:(function() { var ele=document.getElementsByClassName('docs-ml-header-item docs-ml-header-drive-link');ele[0].parentNode.removeChild(ele[0]);var footer = document.getelementsbytagname('footer')[0];footer.parentnode.removechild(footer);})()");
              },
              onProgressChanged: (controller, progress) => setState(() {
                _progress = progress;
              }),
              initialUrlRequest: URLRequest(
                url: Uri.parse(widget.p),
              ),
            ),
            if (_progress != 100)
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> rate(SharedPreferences shPre) async {
  final rev = InAppReview.instance;
  bool alreadyRated = shPre.getBool('rate') ?? false;
  if (!alreadyRated) {
    if (await rev.isAvailable()) {
      rev.requestReview();
      await shPre.setBool('rate', true);
    }
  }
}
