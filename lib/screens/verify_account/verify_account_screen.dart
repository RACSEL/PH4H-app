import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 17, 32, 46),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/logo.png",
                        width: 60,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                          AppLocalizations.of(context)!
                              .verifyAccountScreenTitle,
                          style: TextStyle(fontSize: 36)),
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Text(
                            AppLocalizations.of(context)!
                                .verifyAccountScreenDescription,
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FilledButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/login', (route) => false);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.loginButtonLabel,
                                style: TextStyle(fontSize: 20),
                              )),
                        ],
                      )
                    ]))));
  }
}
