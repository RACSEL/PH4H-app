import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff0061a4),
      surfaceTint: Color(0xff0061a4),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2196f3),
      onPrimaryContainer: Color(0xff002c4f),
      secondary: Color(0xff5e5e5f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff9e9e9e),
      onSecondaryContainer: Color(0xff343636),
      tertiary: Color(0xff24389c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3f51b5),
      onTertiaryContainer: Color(0xffcacfff),
      error: Color(0xffb81311),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffdc3128),
      onErrorContainer: Color(0xfffffbff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff181c22),
      onSurfaceVariant: Color(0xff404752),
      outline: Color(0xff707883),
      outlineVariant: Color(0xffbfc7d4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3137),
      inversePrimary: Color(0xff9ecaff),
      primaryFixed: Color(0xffd1e4ff),
      onPrimaryFixed: Color(0xff001d36),
      primaryFixedDim: Color(0xff9ecaff),
      onPrimaryFixedVariant: Color(0xff00497d),
      secondaryFixed: Color(0xffe3e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc7c6c6),
      onSecondaryFixedVariant: Color(0xff464747),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff00105c),
      tertiaryFixedDim: Color(0xffbac3ff),
      onTertiaryFixedVariant: Color(0xff293ca0),
      surfaceDim: Color(0xffd7dae2),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3fc),
      surfaceContainer: Color(0xffebeef6),
      surfaceContainerHigh: Color(0xffe5e8f0),
      surfaceContainerHighest: Color(0xffdfe2ea),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003862),
      surfaceTint: Color(0xff0061a4),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff0070bc),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff353636),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6c6d6d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff13298f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3f51b5),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740003),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffd12921),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff0d1117),
      onSurfaceVariant: Color(0xff2f3741),
      outline: Color(0xff4b535e),
      outlineVariant: Color(0xff666e79),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3137),
      inversePrimary: Color(0xff9ecaff),
      primaryFixed: Color(0xff0070bc),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005794),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff6c6d6d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff545555),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5364c9),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff394baf),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc3c6ce),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f3fc),
      surfaceContainer: Color(0xffe5e8f0),
      surfaceContainerHigh: Color(0xffdadde5),
      surfaceContainerHighest: Color(0xffced2d9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002e51),
      surfaceTint: Color(0xff0061a4),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b81),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b2c2c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff484949),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff001b86),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2c3fa3),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff610002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff980006),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8f9ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252d37),
      outlineVariant: Color(0xff424a55),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3137),
      inversePrimary: Color(0xff9ecaff),
      primaryFixed: Color(0xff004b81),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00345c),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff484949),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff323333),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2c3fa3),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff0d248c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb5b9c0),
      surfaceBright: Color(0xfff8f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef1f9),
      surfaceContainer: Color(0xffdfe2ea),
      surfaceContainerHigh: Color(0xffd1d4dc),
      surfaceContainerHighest: Color(0xffc3c6ce),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ecaff),
      surfaceTint: Color(0xff9ecaff),
      onPrimary: Color(0xff003258),
      primaryContainer: Color(0xff2196f3),
      onPrimaryContainer: Color(0xff002c4f),
      secondary: Color(0xffc7c6c6),
      onSecondary: Color(0xff2f3131),
      secondaryContainer: Color(0xff9e9e9e),
      onSecondaryContainer: Color(0xff343636),
      tertiary: Color(0xffbac3ff),
      onTertiary: Color(0xff08218a),
      tertiaryContainer: Color(0xff3f51b5),
      onTertiaryContainer: Color(0xffcacfff),
      error: Color(0xffffb4a9),
      onError: Color(0xff690002),
      errorContainer: Color(0xffff5545),
      onErrorContainer: Color(0xff450001),
      surface: Color(0xff0f1419),
      onSurface: Color(0xffdfe2ea),
      onSurfaceVariant: Color(0xffbfc7d4),
      outline: Color(0xff89919d),
      outlineVariant: Color(0xff404752),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe2ea),
      inversePrimary: Color(0xff0061a4),
      primaryFixed: Color(0xffd1e4ff),
      onPrimaryFixed: Color(0xff001d36),
      primaryFixedDim: Color(0xff9ecaff),
      onPrimaryFixedVariant: Color(0xff00497d),
      secondaryFixed: Color(0xffe3e2e2),
      onSecondaryFixed: Color(0xff1a1c1c),
      secondaryFixedDim: Color(0xffc7c6c6),
      onSecondaryFixedVariant: Color(0xff464747),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff00105c),
      tertiaryFixedDim: Color(0xffbac3ff),
      onTertiaryFixedVariant: Color(0xff293ca0),
      surfaceDim: Color(0xff0f1419),
      surfaceBright: Color(0xff353940),
      surfaceContainerLowest: Color(0xff0a0e14),
      surfaceContainerLow: Color(0xff181c22),
      surfaceContainer: Color(0xff1c2026),
      surfaceContainerHigh: Color(0xff262a30),
      surfaceContainerHighest: Color(0xff31353b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc6deff),
      surfaceTint: Color(0xff9ecaff),
      onPrimary: Color(0xff002746),
      primaryContainer: Color(0xff2196f3),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffdddcdc),
      onSecondary: Color(0xff252626),
      secondaryContainer: Color(0xff9e9e9e),
      onSecondaryContainer: Color(0xff101111),
      tertiary: Color(0xffd6daff),
      onTertiary: Color(0xff001775),
      tertiaryContainer: Color(0xff7789f0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540002),
      errorContainer: Color(0xffff5545),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1419),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5ddea),
      outline: Color(0xffabb2bf),
      outlineVariant: Color(0xff89919d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe2ea),
      inversePrimary: Color(0xff004a7f),
      primaryFixed: Color(0xffd1e4ff),
      onPrimaryFixed: Color(0xff001225),
      primaryFixedDim: Color(0xff9ecaff),
      onPrimaryFixedVariant: Color(0xff003862),
      secondaryFixed: Color(0xffe3e2e2),
      onSecondaryFixed: Color(0xff101112),
      secondaryFixedDim: Color(0xffc7c6c6),
      onSecondaryFixedVariant: Color(0xff353636),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000841),
      tertiaryFixedDim: Color(0xffbac3ff),
      onTertiaryFixedVariant: Color(0xff13298f),
      surfaceDim: Color(0xff0f1419),
      surfaceBright: Color(0xff41454b),
      surfaceContainerLowest: Color(0xff04080d),
      surfaceContainerLow: Color(0xff1a1e24),
      surfaceContainer: Color(0xff24282e),
      surfaceContainerHigh: Color(0xff2f3339),
      surfaceContainerHighest: Color(0xff3a3e44),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe8f0ff),
      surfaceTint: Color(0xff9ecaff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff97c6ff),
      onPrimaryContainer: Color(0xff000c1b),
      secondary: Color(0xfff1f0ef),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffc3c2c2),
      onSecondaryContainer: Color(0xff0a0b0c),
      tertiary: Color(0xffefeeff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb5bfff),
      onTertiaryContainer: Color(0xff000532),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea3),
      onErrorContainer: Color(0xff220000),
      surface: Color(0xff0f1419),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f0fe),
      outlineVariant: Color(0xffbbc3d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe2ea),
      inversePrimary: Color(0xff004a7f),
      primaryFixed: Color(0xffd1e4ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9ecaff),
      onPrimaryFixedVariant: Color(0xff001225),
      secondaryFixed: Color(0xffe3e2e2),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffc7c6c6),
      onSecondaryFixedVariant: Color(0xff101112),
      tertiaryFixed: Color(0xffdee0ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbac3ff),
      onTertiaryFixedVariant: Color(0xff000841),
      surfaceDim: Color(0xff0f1419),
      surfaceBright: Color(0xff4c5057),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c2026),
      surfaceContainer: Color(0xff2d3137),
      surfaceContainerHigh: Color(0xff383c42),
      surfaceContainerHighest: Color(0xff43474d),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  static const landingButton = ExtendedColor(
    seed: Color(0xffffffff),
    value: Color(0xffffffff),
    light: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffffff),
      onColorContainer: Color(0xff747676),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffffff),
      onColorContainer: Color(0xff747676),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff5d5f5f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffffffff),
      onColorContainer: Color(0xff747676),
    ),
    dark: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffffffff),
      onColor: Color(0xff2f3131),
      colorContainer: Color(0xffe2e2e2),
      onColorContainer: Color(0xff636565),
    ),
  );

  List<ExtendedColor> get extendedColors => [
        landingButton,
      ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
