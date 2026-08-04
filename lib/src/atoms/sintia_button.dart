import 'dart:async';

import 'package:flutter/material.dart';

import '../foundations/sintia_size.dart';
import '../foundations/sintia_sizes.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';
import 'sintia_loader.dart';

/// Variantes visuales de [SintiaButton], en orden de énfasis.
enum SintiaButtonVariant {
  /// Acción principal de la pantalla (relleno con el color de marca).
  primary,

  /// Acción secundaria (relleno tonal).
  secondary,

  /// Acción de énfasis medio (solo borde).
  outline,

  /// Acción de bajo énfasis (solo texto).
  ghost,

  /// Acción destructiva (relleno con el color de error del tema).
  danger,
}

/// Botón del sistema de diseño.
///
/// Actúa como fachada sobre los botones de Material para que hereden el
/// estilo definido en `SintiaTheme`, agregando variantes, tamaños e
/// **indicador de carga automático**: si [onPressed] devuelve un `Future`,
/// el botón se bloquea y muestra el loader hasta que se complete.
///
/// ```dart
/// SintiaButton(
///   label: 'Guardar',
///   icon: Icons.check,
///   onPressed: () async => repository.save(form),
/// );
/// ```
///
/// Para controlar el estado de carga desde fuera (por ejemplo, desde un
/// gestor de estado), usar [loading].
///
/// [backgroundColor], [foregroundColor] y [borderRadius] son overrides
/// puntuales para un botón que necesita salirse de su [variant] o del
/// tema; para toda la app, la vía es `SintiaTheme` / `*ButtonThemeData`.
///
/// ```dart
/// SintiaButton(
///   label: 'Continuar',
///   backgroundColor: Colors.amber,
///   foregroundColor: Colors.black,
///   borderRadius: BorderRadius.circular(999),
///   onPressed: () {},
/// );
/// ```
class SintiaButton extends StatefulWidget {
  const SintiaButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = SintiaButtonVariant.primary,
    this.size = SintiaSize.medium,
    this.icon,
    this.trailingIcon,
    this.loading = false,
    this.loadingLabel,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.expanded = false,
    this.semanticIdentifier,
  });

  final String label;

  /// Acción del botón. Acepta callbacks sincrónicos y asíncronos: si
  /// devuelve un `Future`, el botón gestiona su propio estado de carga.
  ///
  /// Si es null (o [loading] es true) el botón se muestra deshabilitado.
  final FutureOr<void> Function()? onPressed;

  final SintiaButtonVariant variant;
  final SintiaSize size;

  /// Ícono a la izquierda de la etiqueta.
  final IconData? icon;

  /// Ícono a la derecha de la etiqueta.
  final IconData? trailingIcon;

  /// Fuerza el estado de carga desde fuera.
  final bool loading;

  /// Etiqueta mostrada junto al loader mientras carga. Si es null solo se
  /// muestra el loader.
  final String? loadingLabel;

  /// Color de fondo para este botón puntual. Si es null, usa el de
  /// [variant] o, en su defecto, el del tema.
  final Color? backgroundColor;

  /// Color del texto y los íconos para este botón puntual. Si es null,
  /// usa el de [variant] o, en su defecto, el del tema.
  final Color? foregroundColor;

  /// Radio de borde para este botón puntual. Si es null, usa
  /// `SintiaRadius.borderMedium` del tema.
  final BorderRadius? borderRadius;

  /// Ocupa todo el ancho disponible.
  final bool expanded;

  /// Identificador semántico para pruebas de automatización.
  final String? semanticIdentifier;

  @override
  State<SintiaButton> createState() => _SintiaButtonState();
}

class _SintiaButtonState extends State<SintiaButton> {
  /// Carga gestionada por el propio botón (cuando [onPressed] es async).
  bool _pending = false;

  bool get _isLoading => widget.loading || _pending;

  bool get _isDisabled => widget.onPressed == null || _isLoading;

  double get _height => switch (widget.size) {
    SintiaSize.small => SintiaSizes.size36,
    SintiaSize.medium => SintiaSizes.size44,
    SintiaSize.large => SintiaSizes.size52,
  };

  double get _horizontalPadding => switch (widget.size) {
    SintiaSize.small => SintiaSpacing.medium,
    SintiaSize.medium => SintiaSpacing.large,
    SintiaSize.large => SintiaSpacing.extraLarge,
  };

  double get _iconSize => switch (widget.size) {
    SintiaSize.small => SintiaIconSize.small,
    SintiaSize.medium => SintiaIconSize.small,
    SintiaSize.large => SintiaIconSize.medium,
  };

  TextStyle? _textStyle(BuildContext context) => switch (widget.size) {
    SintiaSize.small => context.textTheme.labelMedium,
    SintiaSize.medium => context.textTheme.labelLarge,
    SintiaSize.large => context.textTheme.titleSmall,
  };

  Future<void> _handlePressed() async {
    final FutureOr<void> Function()? onPressed = widget.onPressed;
    if (onPressed == null || _isLoading) return;

    final FutureOr<void> result = onPressed();
    if (result is! Future<void>) return;

    setState(() => _pending = true);
    try {
      await result;
    } finally {
      if (mounted) setState(() => _pending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final VoidCallback? effectiveOnPressed = _isDisabled
        ? null
        : () => unawaited(_handlePressed());

    final ButtonStyle sizeStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll<Size>(Size(0, _height)),
      padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
        EdgeInsets.symmetric(horizontal: _horizontalPadding),
      ),
      textStyle: WidgetStatePropertyAll<TextStyle?>(_textStyle(context)),
    );

    final Widget child = _isLoading
        ? _SintiaButtonLoader(label: widget.loadingLabel)
        : _SintiaButtonContent(
            label: widget.label,
            icon: widget.icon,
            trailingIcon: widget.trailingIcon,
            iconSize: _iconSize,
          );

    final ButtonStyle variantStyle = switch (widget.variant) {
      SintiaButtonVariant.danger => sizeStyle.merge(
        FilledButton.styleFrom(
          backgroundColor: context.colorScheme.error,
          foregroundColor: context.colorScheme.onError,
        ),
      ),
      SintiaButtonVariant.primary ||
      SintiaButtonVariant.secondary ||
      SintiaButtonVariant.outline ||
      SintiaButtonVariant.ghost => sizeStyle,
    };

    // Los overrides puntuales ganan sobre la variante y el tema: un
    // ButtonStyle solo rellena sus campos null con los de la variante.
    final BorderRadius? borderRadius = widget.borderRadius;
    final ButtonStyle overrideStyle = ButtonStyle(
      backgroundColor: widget.backgroundColor == null
          ? null
          : WidgetStatePropertyAll<Color>(widget.backgroundColor!),
      foregroundColor: widget.foregroundColor == null
          ? null
          : WidgetStatePropertyAll<Color>(widget.foregroundColor!),
      shape: borderRadius == null
          ? null
          : WidgetStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: borderRadius),
            ),
    );
    final ButtonStyle style = overrideStyle.merge(variantStyle);

    final ButtonStyleButton button = switch (widget.variant) {
      SintiaButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      SintiaButtonVariant.secondary => FilledButton.tonal(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      SintiaButtonVariant.outline => OutlinedButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      SintiaButtonVariant.ghost => TextButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
      SintiaButtonVariant.danger => FilledButton(
        onPressed: effectiveOnPressed,
        style: style,
        child: child,
      ),
    };

    return Semantics(
      identifier:
          widget.semanticIdentifier ?? 'sintia_button_${widget.variant.name}',
      button: true,
      enabled: !_isDisabled,
      child: widget.expanded
          ? SizedBox(width: double.infinity, child: button)
          : button,
    );
  }
}

/// Contenido del botón en reposo: etiqueta con íconos opcionales.
class _SintiaButtonContent extends StatelessWidget {
  const _SintiaButtonContent({
    required this.label,
    required this.iconSize,
    this.icon,
    this.trailingIcon,
  });

  final String label;
  final double iconSize;
  final IconData? icon;
  final IconData? trailingIcon;

  @override
  Widget build(BuildContext context) {
    final IconData? icon = this.icon;
    final IconData? trailingIcon = this.trailingIcon;
    if (icon == null && trailingIcon == null) return Text(label);

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: SintiaSpacing.small,
      children: <Widget>[
        if (icon != null) Icon(icon, size: iconSize),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
        if (trailingIcon != null) Icon(trailingIcon, size: iconSize),
      ],
    );
  }
}

/// Contenido del botón mientras carga.
class _SintiaButtonLoader extends StatelessWidget {
  const _SintiaButtonLoader({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    const Widget loader = SintiaLoader(size: SintiaSize.small);
    final String? label = this.label;
    if (label == null) return loader;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: SintiaSpacing.small,
      children: <Widget>[
        loader,
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Variantes', group: 'SintiaButton')
Widget sintiaButtonVariantsPreview() => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaButton(label: 'Primary', onPressed: () {}),
    SintiaButton(
      label: 'Secondary',
      variant: SintiaButtonVariant.secondary,
      onPressed: () {},
    ),
    SintiaButton(
      label: 'Outline',
      variant: SintiaButtonVariant.outline,
      onPressed: () {},
    ),
    SintiaButton(
      label: 'Ghost',
      variant: SintiaButtonVariant.ghost,
      onPressed: () {},
    ),
    SintiaButton(
      label: 'Danger',
      variant: SintiaButtonVariant.danger,
      onPressed: () {},
    ),
  ],
);

@SintiaPreview(name: 'Tamaños y estados', group: 'SintiaButton')
Widget sintiaButtonSizesPreview() => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaButton(label: 'Small', size: SintiaSize.small, onPressed: () {}),
    SintiaButton(label: 'Medium', icon: Icons.check, onPressed: () {}),
    SintiaButton(label: 'Large', size: SintiaSize.large, onPressed: () {}),
    const SintiaButton(label: 'Deshabilitado'),
    const SintiaButton(label: 'Cargando', loading: true),
  ],
);

@SintiaPreview(name: 'Personalizado', group: 'SintiaButton')
Widget sintiaButtonCustomPreview() => Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaButton(
      label: 'Amarillo',
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
      onPressed: () {},
    ),
    SintiaButton(
      label: 'Sin radio',
      variant: SintiaButtonVariant.outline,
      borderRadius: BorderRadius.zero,
      onPressed: () {},
    ),
  ],
);
// coverage:ignore-end
