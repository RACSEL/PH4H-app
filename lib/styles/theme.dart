import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ips_lacpass_app/styles/color_theme.dart';

// Example: A SlideTransition from Right to Left
class _SlideRightLeftTransitionBuilder extends PageTransitionsBuilder {
  const _SlideRightLeftTransitionBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double>
        animation, // This is the primary animation for the new route
    Animation<double>
        secondaryAnimation, // This is for the existing route when a new one pushes on top
    Widget child,
  ) {
    // Make the new page slide in from the right
    final newPageSlide = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start offscreen to the right
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(
      parent: animation, // Animate based on the new route's animation
      curve: Curves.easeOutCubic, // Or any other curve you like
    ));

    // Make the old page slide out to the left
    final oldPageSlide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.3, 0.0), // Slide slightly to the left
    ).animate(CurvedAnimation(
      parent: secondaryAnimation, // Animate based on the old route's animation
      curve: Curves.easeInCubic,
    ));

    return SlideTransition(
      position: oldPageSlide, // Apply to the old page container if needed
      child: SlideTransition(
        position: newPageSlide,
        child: child, // The new page
      ),
    );
  }
}

final appTheme = ThemeData(
    useMaterial3: true,
    colorScheme: MaterialTheme.lightScheme(),
    textTheme: GoogleFonts.jostTextTheme(),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
              // You can customize based on states if needed
              // For example, if you want a different color when the button is disabled
              if (states.contains(WidgetState.disabled)) {
                return BorderSide(color: Colors.grey.shade300, width: 1);
              }
              return BorderSide(
                color: Colors
                    .black, // Your default border color for all OutlinedButtons
              );
            },
          )),
    ),
    filledButtonTheme: FilledButtonThemeData(
      // For FilledButton
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      // For FilledButton
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _SlideRightLeftTransitionBuilder(),
        TargetPlatform.iOS: _SlideRightLeftTransitionBuilder(),
      },
    ),
    expansionTileTheme: ExpansionTileThemeData(
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            side: BorderSide(
              color: Colors.grey,
            )),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            side: BorderSide(
              color: Colors.grey,
            ))),
    chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    )));
