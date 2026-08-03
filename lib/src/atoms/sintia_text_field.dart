import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_spacing.dart';
import 'sintia_text.dart';

/// Campo de texto del sistema de diseño.
///
/// Hereda la decoración definida en `SintiaTheme` (bordes, relleno, estados
/// de foco y error), muestra la etiqueta **sobre** el campo y gestiona
/// automáticamente la visibilidad de los campos de contraseña.
///
/// ```dart
/// SintiaTextField(
///   label: 'Correo',
///   hint: 'tu@correo.com',
///   keyboardType: TextInputType.emailAddress,
///   validator: (String? value) =>
///       (value ?? '').contains('@') ? null : 'Correo inválido',
/// );
/// ```
class SintiaTextField extends StatefulWidget {
  const SintiaTextField({
    super.key,
    this.label,
    this.labelStyle,
    this.hint,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autovalidateMode,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.validator,
    this.semanticIdentifier,
  });

  /// Etiqueta mostrada sobre el campo. Si es null no se reserva espacio.
  final String? label;

  /// Estilo de la etiqueta solo para este campo. Si es null usa el del tema
  /// (`inputDecorationTheme.labelStyle`), que se configura una sola vez con
  /// `SintiaThemeConfig.inputLabelColor`.
  final TextStyle? labelStyle;
  final String? hint;

  /// Texto de ayuda bajo el campo.
  final String? helperText;

  /// Mensaje de error manual. Para validación de formularios usar
  /// [validator].
  final String? errorText;

  final TextEditingController? controller;

  /// Valor inicial. Solo se usa si [controller] es null.
  final String? initialValue;

  final IconData? prefixIcon;

  /// Widget al final del campo. Se ignora si [obscureText] es true, porque
  /// ese espacio lo ocupa el botón de mostrar/ocultar.
  final Widget? suffixIcon;

  /// Oculta el texto y muestra un botón para alternar la visibilidad.
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Útil para campos de solo lectura que abren un selector.
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  /// Identificador semántico para pruebas de automatización.
  final String? semanticIdentifier;

  @override
  State<SintiaTextField> createState() => _SintiaTextFieldState();
}

class _SintiaTextFieldState extends State<SintiaTextField> {
  late bool _obscured = widget.obscureText;

  void _toggleObscured() => setState(() => _obscured = !_obscured);

  /// Estilo de la etiqueta: el del campo, el del tema o el del sistema.
  TextStyle? _labelStyle(BuildContext context) =>
      widget.labelStyle ??
      context.theme.inputDecorationTheme.labelStyle ??
      context.textTheme.labelLarge?.semiBold;

  @override
  Widget build(BuildContext context) {
    final String? label = widget.label;

    final Widget field = TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: _obscured,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      autovalidateMode: widget.autovalidateMode,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      validator: widget.validator,
      style: context.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: widget.hint,
        helperText: widget.helperText,
        errorText: widget.errorText,
        counterText: '',
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: _toggleObscured,
                tooltip: _obscured ? 'Mostrar' : 'Ocultar',
                icon: Icon(
                  _obscured ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : widget.suffixIcon,
      ),
    );

    return Semantics(
      identifier: widget.semanticIdentifier ?? 'sintia_text_field',
      label: label,
      textField: true,
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
@SintiaPreview(name: 'Variantes', group: 'SintiaTextField')
Widget sintiaTextFieldPreview() => const Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.medium,
  children: <Widget>[
    SintiaTextField(
      label: 'Correo',
      hint: 'tu@correo.com',
      prefixIcon: Icons.mail_outline,
    ),
    SintiaTextField(label: 'Contraseña', obscureText: true),
    SintiaTextField(
      label: 'Documento',
      errorText: 'El documento es requerido',
    ),
    SintiaTextField(label: 'Deshabilitado', enabled: false),
  ],
);
// coverage:ignore-end
