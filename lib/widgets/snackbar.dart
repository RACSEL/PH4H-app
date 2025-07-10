import 'package:flutter/material.dart';

void showTopSnackBar(BuildContext context, String message,
    {Color? backgroundColor, Color? textColor}) {
  final overlay = Overlay.of(context);
  final theme = Theme.of(context);

  final bgColor = backgroundColor ?? theme.colorScheme.error;
  final fgColor = textColor ?? theme.colorScheme.onError;

  final controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 200),
    vsync: Navigator.of(context),
  );

  final offsetAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  ));

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: MediaQuery.of(context).padding.top + 16, // below status bar
      left: 16,
      right: 16,
      child: SlideTransition(
        position: offsetAnimation,
        child: Material(
          borderRadius: BorderRadius.circular(4),
          color: bgColor,
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              message,
              style: TextStyle(
                color: fgColor,
                fontSize: theme.textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
  controller.forward();

  Future.delayed(const Duration(seconds: 2), () async {
    await controller.reverse();
    overlayEntry.remove();
    controller.dispose();
  });
}
