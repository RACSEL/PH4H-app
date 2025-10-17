import 'package:flutter/material.dart';

class ResourceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> items;

  const ResourceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> childrenWithDividers = List.generate(
      items.length * 2 - 1,
      (index) {
        if (index.isEven) {
          return items[index ~/ 2];
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(height: 1),
          );
        }
      },
    );

    return Column(
      children: [
        ExpansionTile(
          initiallyExpanded: true,
          title: Row(
            children: [
              Icon(icon, size: 28),
              const SizedBox(width: 10),
              Text(title),
            ],
          ),
          children: <Widget>[
            const Divider(height: 1),
            ...childrenWithDividers,
          ],
        ),
        const SizedBox(height: 23),
      ],
    );
  }
}
