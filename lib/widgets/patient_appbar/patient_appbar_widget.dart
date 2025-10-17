import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/user_model.dart';
import 'package:ips_lacpass_app/screens/settings/settings_screen.dart';

class PatientAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final Function? goBackCallback;
  final List<Widget>? additionalActions;

  const PatientAppBar({super.key, this.goBackCallback, this.additionalActions});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Widget> actions = [];
    if (additionalActions != null && additionalActions!.isNotEmpty) {
      actions = [
        ...additionalActions!,
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
        ),
      ];
    } else {
      actions = [
        IconButton(
          color: Theme.of(context).colorScheme.primary,
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            );
          },
        ),
      ];
    }
    return AppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () {
                if (goBackCallback != null) {
                  goBackCallback!();
                }
                Navigator.pop(context);
              },
              icon: Icon(Icons.chevron_left),
            )
          : null,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing: Navigator.canPop(context) ? 0 : null,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/icon/logo.png',
              height: 40,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${ref.read(userModelProvider)?.firstName} ${ref.read(userModelProvider)?.lastName}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.onSurface),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "${ref.read(userModelProvider)?.identifier}",
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }
}
