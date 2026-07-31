import 'package:flutter/material.dart';

import 'sintia_theme_context_extension.dart';

/// Composición fluida de estilos de texto sobre los del tema.
///
/// Evita repetir `copyWith` en la UI y mantiene los pesos tipográficos
/// alineados al sistema.
///
/// ```dart
/// Text('Total', style: context.textTheme.titleMedium!.bold.primary(context));
/// ```
extension SintiaTextStyleExtension on TextStyle {
  /// Pinta el texto con el color de marca.
  TextStyle primary(BuildContext context) =>
      copyWith(color: context.colorScheme.primary);

  /// Pinta el texto con el color de acento.
  TextStyle secondary(BuildContext context) =>
      copyWith(color: context.colorScheme.secondary);

  /// Pinta el texto con el color de error.
  TextStyle error(BuildContext context) =>
      copyWith(color: context.colorScheme.error);

  /// Pinta el texto con el color de contenido secundario.
  TextStyle muted(BuildContext context) =>
      copyWith(color: context.colorScheme.onSurfaceVariant);

  /// Pinta el texto con un color explícito.
  TextStyle withColor(Color color) => copyWith(color: color);

  /// Peso regular (400).
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Peso medio (500).
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Peso semi-negrita (600).
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Peso negrita (700).
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
}
