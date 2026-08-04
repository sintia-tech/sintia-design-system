import 'package:flutter/material.dart';

import '../models/sintia_dropdown_item.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';
import 'sintia_text.dart';

/// Selector desplegable del sistema de diseño.
///
/// Hereda la misma decoración que `SintiaTextField` (relleno, borde, radio y
/// estados de foco y error definidos en `inputDecorationTheme`), así que
/// ambos conviven en un formulario sin desentonar. Muestra la etiqueta
/// **sobre** el campo, igual que el resto de los campos.
///
/// ```dart
/// SintiaDropdown<String>(
///   label: 'País',
///   hint: 'Elige un país',
///   value: country,
///   items: const <SintiaDropdownItem<String>>[
///     SintiaDropdownItem<String>(value: 'co', label: 'Colombia'),
///     SintiaDropdownItem<String>(value: 'mx', label: 'México'),
///   ],
///   onChanged: (String? value) => setState(() => country = value),
/// );
/// ```
///
/// [itemTextStyle], [menuBackgroundColor] y [borderRadius] son overrides
/// puntuales del menú desplegado para un caso que necesita salirse del
/// tema; el resto de la decoración del campo (relleno, borde) sigue
/// saliendo de `inputDecorationTheme`, igual que en `SintiaTextField`.
///
/// [value] fija el valor mostrado al construir el campo. Si necesitás
/// cambiarlo desde afuera del propio [onChanged] (por ejemplo, un botón
/// «limpiar»), agregá `key: ValueKey(value)` a la instancia: mismo
/// comportamiento que `SintiaTextField.initialValue`.
class SintiaDropdown<T> extends StatelessWidget {
  const SintiaDropdown({
    required this.items,
    super.key,
    this.value,
    this.onChanged,
    this.label,
    this.labelStyle,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.enabled = true,
    this.itemTextStyle,
    this.menuBackgroundColor,
    this.borderRadius,
    this.validator,
    this.semanticIdentifier,
  });

  /// Opciones disponibles, en el orden en que se dibujan.
  final List<SintiaDropdownItem<T>> items;

  /// Valor mostrado al construir el campo. Si no coincide con ningún ítem,
  /// no se muestra ninguna opción elegida.
  final T? value;

  /// Notifica el valor elegido. Si es null (o [enabled] es false), el campo
  /// se muestra deshabilitado.
  final ValueChanged<T?>? onChanged;

  /// Etiqueta mostrada sobre el campo. Si es null no se reserva espacio.
  final String? label;

  /// Estilo de la etiqueta solo para este campo. Si es null usa el del
  /// tema (`inputDecorationTheme.labelStyle`), igual que
  /// `SintiaTextField.labelStyle`.
  final TextStyle? labelStyle;

  /// Texto mostrado cuando no hay ninguna opción elegida.
  final String? hint;

  /// Texto de ayuda bajo el campo.
  final String? helperText;

  /// Mensaje de error manual. Para validación de formularios usar
  /// [validator].
  final String? errorText;

  final IconData? prefixIcon;

  /// Si es false, el campo se muestra deshabilitado y no notifica.
  final bool enabled;

  /// Estilo del texto de la opción elegida y de cada ítem del menú. Si es
  /// null, usa `bodyLarge`.
  final TextStyle? itemTextStyle;

  /// Color de fondo del menú desplegado. Si es null, usa el color de
  /// superficie del tema.
  final Color? menuBackgroundColor;

  /// Radio de borde del menú desplegado. Si es null, usa el del tema.
  final BorderRadius? borderRadius;

  /// Validación dentro de un `Form`.
  final FormFieldValidator<T>? validator;

  /// Identificador semántico para pruebas de automatización.
  final String? semanticIdentifier;

  /// Estilo de la etiqueta: el del campo, el del tema o el del sistema.
  TextStyle? _labelStyle(BuildContext context) =>
      labelStyle ??
      context.theme.inputDecorationTheme.labelStyle ??
      context.textTheme.labelLarge?.semiBold;

  @override
  Widget build(BuildContext context) {
    final String? label = this.label;
    final String? hint = this.hint;

    final Widget field = DropdownButtonFormField<T>(
      initialValue: value,
      isExpanded: true,
      items: <DropdownMenuItem<T>>[
        for (final SintiaDropdownItem<T> item in items)
          DropdownMenuItem<T>(
            value: item.value,
            enabled: item.enabled,
            child: item.icon == null
                ? Text(item.label, overflow: TextOverflow.ellipsis)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: SintiaSpacing.small,
                    children: <Widget>[
                      Icon(item.icon, size: SintiaIconSize.small),
                      Flexible(
                        child: Text(
                          item.label,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
          ),
      ],
      onChanged: enabled ? onChanged : null,
      validator: validator,
      style: itemTextStyle ?? context.textTheme.bodyLarge,
      dropdownColor: menuBackgroundColor,
      borderRadius: borderRadius,
      hint: hint == null ? null : Text(hint, overflow: TextOverflow.ellipsis),
      decoration: InputDecoration(
        enabled: enabled,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
    );

    return Semantics(
      identifier: semanticIdentifier ?? 'sintia_dropdown',
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SintiaSpacing.extraSmall,
        children: <Widget>[
          if (label != null) SintiaText(label, style: _labelStyle(context)),
          field,
        ],
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Variantes', group: 'SintiaDropdown')
Widget sintiaDropdownPreview() => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.medium,
  children: <Widget>[
    SintiaDropdown<String>(
      label: 'País',
      hint: 'Elige un país',
      items: const <SintiaDropdownItem<String>>[
        SintiaDropdownItem<String>(value: 'co', label: 'Colombia'),
        SintiaDropdownItem<String>(value: 'mx', label: 'México'),
        SintiaDropdownItem<String>(value: 'ar', label: 'Argentina'),
      ],
      onChanged: (_) {},
    ),
    SintiaDropdown<String>(
      label: 'Categoría',
      value: 'home',
      items: const <SintiaDropdownItem<String>>[
        SintiaDropdownItem<String>(
          value: 'home',
          label: 'Hogar',
          icon: Icons.home_outlined,
        ),
        SintiaDropdownItem<String>(
          value: 'work',
          label: 'Trabajo',
          icon: Icons.work_outline,
        ),
      ],
      onChanged: (_) {},
    ),
    const SintiaDropdown<String>(
      label: 'Deshabilitado',
      hint: 'No disponible',
      items: <SintiaDropdownItem<String>>[],
      enabled: false,
    ),
  ],
);

@SintiaPreview(name: 'Personalizado', group: 'SintiaDropdown')
Widget sintiaDropdownCustomPreview() => SintiaDropdown<String>(
  label: 'Idioma',
  value: 'es',
  items: const <SintiaDropdownItem<String>>[
    SintiaDropdownItem<String>(value: 'es', label: 'Español'),
    SintiaDropdownItem<String>(value: 'en', label: 'English'),
  ],
  itemTextStyle: const TextStyle(fontWeight: FontWeight.bold),
  menuBackgroundColor: Colors.amber,
  borderRadius: const BorderRadius.all(Radius.circular(4)),
  onChanged: (_) {},
);
// coverage:ignore-end
