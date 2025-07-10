import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;
  const SettingsAppBar({required this.title, super.key});

  @override
  ConsumerState<SettingsAppBar> createState() => _SettingsAppBar();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SettingsAppBar extends ConsumerState<SettingsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.chevron_left),
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing: 0,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/icon/logo.png',
              height: 40,
            ),
          ),
          Text(widget.title),
        ],
      ),
    );
  }
}
