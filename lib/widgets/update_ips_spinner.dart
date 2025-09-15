import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

class UpdateIpsSpinner extends ConsumerWidget {
  const UpdateIpsSpinner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(ipsModelProvider).merge(ref.read(ipsVhlModelProvider).bundle).then((resp) {
      Navigator.pushNamedAndRemoveUntil(
          context,
          "/ips",
          (Route<dynamic> route) => false
      );
    }).onError((error, stackTrace) {
        print("Going back");
        showTopSnackBar(context, AppLocalizations.of(context)!.unexpectedErrorMessage);
        Navigator.pop(context);
    });

    return Scaffold(
      appBar: PatientAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .updatingIpsDataTitle,
                      style: TextStyle(fontSize: 36)),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        constraints: BoxConstraints(
                            minHeight: 48, minWidth: 48),
                      ))
                ])),
      )
    );
  }

}