import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../theme/sintia_theme.dart';
import '../theme/sintia_theme_config.dart';

/// Anotación de Widget Preview con el tema del sistema ya aplicado.
///
/// Equivale a `@Preview`, pero inyecta `SintiaTheme` (claro y oscuro) para
/// que el componente se vea en el IDE tal como se verá en producción.
///
/// ```dart
/// @SintiaPreview(name: 'Primary', group: 'SintiaButton')
/// Widget primaryButtonPreview() =>
///     SintiaButton(label: 'Guardar', onPressed: () {});
/// ```
final class SintiaPreview extends Preview {
  const SintiaPreview({
    super.name,
    super.group,
    super.size,
    super.textScaleFactor,
    super.wrapper,
    super.brightness,
    super.localizations,
  }) : super(theme: SintiaPreview._themeBuilder);

  /// Marca de demostración usada solo en previews. Las apps consumidoras
  /// inyectan la suya vía [SintiaThemeConfig].
  static const SintiaThemeConfig previewConfig = SintiaThemeConfig(
    primary: Color(0xFF4F46E5),
    secondary: Color(0xFF0D9488),
  );

  static PreviewThemeData _themeBuilder() {
    return PreviewThemeData(
      materialLight: SintiaTheme.light(previewConfig),
      materialDark: SintiaTheme.dark(previewConfig),
    );
  }
}
