import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/api/ips_loader.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/styles/color_theme.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IPSLoader.instance.clearStoredIps();
    return Scaffold(
      body: SizedBox.expand(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/landing_bg.png"),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: SafeArea(
            child: Column(
              children: [
                Spacer(flex: 3),
                Center(
                  child: RichText(
                      text: TextSpan(
                          style:
                              TextStyle(fontWeight: FontWeight.w700, height: 1),
                          children: <TextSpan>[
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .landingPageTitlePart1,
                            style: TextStyle(fontSize: 58)),
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .landingPageTitlePart2,
                            style: TextStyle(fontSize: 39)),
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .landingPageTitlePart3,
                            style: TextStyle(fontSize: 65)),
                        TextSpan(
                            text: AppLocalizations.of(context)!
                                .landingPageTitlePart4,
                            style: TextStyle(fontSize: 60)),
                      ])),
                ),
                Spacer(flex: 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(side:
                            WidgetStateProperty.resolveWith<BorderSide>(
                                (Set<WidgetState> states) {
                          return BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? MaterialTheme
                                        .landingButton.light.colorContainer
                                    : MaterialTheme
                                        .landingButton.dark.colorContainer,
                          );
                        })),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .alreadyHaveAccountButtonLabel,
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? MaterialTheme
                                          .landingButton.light.colorContainer
                                      : MaterialTheme
                                          .landingButton.dark.colorContainer,
                                  fontSize: 18)),
                        )),
                    FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                              AppLocalizations.of(context)!
                                  .createAccountButtonLabel,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18)),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
