import 'package:flutter/material.dart';

import '../tokens/sintia_elevation.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';
import 'sintia_status_colors.dart';
import 'sintia_theme_config.dart';

/// Construye el [ThemeData] del sistema de diseño Sintia.
///
/// El consumidor controla la identidad visual vía [SintiaThemeConfig]
/// (colores de marca, fuentes y colores de estado); el sistema aporta la
/// consistencia: radios, espaciados, elevaciones y estilos de todos los
/// componentes derivados de los tokens.
///
/// Es la **única** fuente de color y tipografía del sistema: ningún
/// componente hardcodea colores, todos los leen del tema.
///
/// ```dart
/// const SintiaThemeConfig config = SintiaThemeConfig(
///   primary: Color(0xFF4F46E5),
/// );
///
/// MaterialApp(
///   theme: SintiaTheme.light(config),
///   darkTheme: SintiaTheme.dark(config),
/// );
/// ```
abstract final class SintiaTheme {
  /// Tema claro a partir de la identidad visual del consumidor.
  static ThemeData light(SintiaThemeConfig config) {
    return _build(
      config: config,
      brightness: Brightness.light,
      statusColors: config.lightStatusColors,
    );
  }

  /// Tema oscuro a partir de la identidad visual del consumidor.
  static ThemeData dark(SintiaThemeConfig config) {
    return _build(
      config: config,
      brightness: Brightness.dark,
      statusColors: config.darkStatusColors,
    );
  }

  static ThemeData _build({
    required SintiaThemeConfig config,
    required Brightness brightness,
    required SintiaStatusColors statusColors,
  }) {
    final ColorScheme colorScheme = _colorScheme(
      config: config,
      brightness: brightness,
    );

    final ThemeData base = ThemeData(
      colorScheme: colorScheme,
      fontFamily: config.fontFamily,
    );

    final String? headingFontFamily = config.headingFontFamily;
    final TextTheme textTheme = headingFontFamily == null
        ? base.textTheme
        : _withHeadingFont(base: base.textTheme, fontFamily: headingFontFamily);

    const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
      borderRadius: SintiaRadius.borderMedium,
    );
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(
      horizontal: SintiaSpacing.large,
      vertical: SintiaSpacing.medium,
    );

    return base.copyWith(
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[statusColors],
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: buttonShape,
          padding: buttonPadding,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(iconSize: SintiaIconSize.large),
      ),
      inputDecorationTheme: _inputDecorationTheme(colorScheme),
      cardTheme: CardThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: SintiaRadius.borderLarge,
        ),
        clipBehavior: Clip.antiAlias,
        elevation: SintiaElevation.none,
        color: colorScheme.surfaceContainerLow,
        margin: EdgeInsets.zero,
      ),
      chipTheme: const ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: SintiaRadius.borderFull),
        padding: EdgeInsets.symmetric(
          horizontal: SintiaSpacing.small,
          vertical: SintiaSpacing.extraSmall,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: SintiaElevation.none,
        scrolledUnderElevation: SintiaElevation.low,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        elevation: SintiaElevation.highest,
        shape: const RoundedRectangleBorder(
          borderRadius: SintiaRadius.borderLarge,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: SintiaElevation.none,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(SintiaRadius.extraLarge),
            bottomRight: Radius.circular(SintiaRadius.extraLarge),
          ),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: SintiaRadius.borderMedium),
        contentPadding: EdgeInsets.symmetric(horizontal: SintiaSpacing.medium),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: SintiaSpacing.medium,
        thickness: 1,
      ),
      tooltipTheme: TooltipThemeData(
        waitDuration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(
          horizontal: SintiaSpacing.small,
          vertical: SintiaSpacing.extraSmall,
        ),
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: SintiaRadius.borderSmall,
        ),
        textStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(
          borderRadius: SintiaRadius.borderMedium,
        ),
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onInverseSurface,
        ),
      ),
      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll<Color>(
            colorScheme.surfaceContainer,
          ),
          surfaceTintColor: const WidgetStatePropertyAll<Color>(
            Colors.transparent,
          ),
          elevation: const WidgetStatePropertyAll<double>(
            SintiaElevation.high,
          ),
          shape: const WidgetStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: SintiaRadius.borderMedium),
          ),
          padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
            EdgeInsets.symmetric(
              vertical: SintiaSpacing.small,
              horizontal: SintiaSpacing.extraSmall,
            ),
          ),
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: MenuItemButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: SintiaRadius.borderSmall,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: SintiaSpacing.medium,
            vertical: SintiaSpacing.small,
          ),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
    );
  }

  static ColorScheme _colorScheme({
    required SintiaThemeConfig config,
    required Brightness brightness,
  }) {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: config.primary,
      brightness: brightness,
    );
    final Color? secondary = config.secondary;
    if (secondary == null) return scheme;
    return scheme.copyWith(secondary: secondary);
  }

  static InputDecorationThemeData _inputDecorationTheme(
    ColorScheme colorScheme,
  ) {
    OutlineInputBorder border(Color color, {double width = 1}) {
      return OutlineInputBorder(
        borderRadius: SintiaRadius.borderMedium,
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return InputDecorationThemeData(
      filled: true,
      fillColor: colorScheme.surfaceContainerLow,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: SintiaSpacing.medium,
        vertical: SintiaSpacing.medium,
      ),
      border: border(colorScheme.outline),
      enabledBorder: border(colorScheme.outlineVariant),
      disabledBorder: border(colorScheme.outlineVariant.withValues(alpha: 0.5)),
      focusedBorder: border(colorScheme.primary, width: 2),
      errorBorder: border(colorScheme.error),
      focusedErrorBorder: border(colorScheme.error, width: 2),
    );
  }

  /// Aplica la fuente de titulares a los estilos display, headline y
  /// titleLarge, dejando el resto con la fuente base.
  static TextTheme _withHeadingFont({
    required TextTheme base,
    required String fontFamily,
  }) {
    TextStyle? heading(TextStyle? style) => style?.copyWith(
      fontFamily: fontFamily,
    );
    return base.copyWith(
      displayLarge: heading(base.displayLarge),
      displayMedium: heading(base.displayMedium),
      displaySmall: heading(base.displaySmall),
      headlineLarge: heading(base.headlineLarge),
      headlineMedium: heading(base.headlineMedium),
      headlineSmall: heading(base.headlineSmall),
      titleLarge: heading(base.titleLarge),
    );
  }
}
