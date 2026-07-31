import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../foundations/sintia_sizes.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Opción de aceptación con círculo seleccionable y texto que puede incluir
/// un enlace (ej. "Acepto **Términos y condiciones**").
///
/// El enlace ([linkText]) se pinta con el color de marca y dispara
/// [onLinkTap] (típicamente abre un diálogo legal). Toda la fila es área
/// táctil para alternar el valor.
///
/// ```dart
/// SintiaCheckOption(
///   value: accepted,
///   onChanged: (bool value) => setState(() => accepted = value),
///   label: 'Acepto los',
///   linkText: 'Términos y condiciones',
///   onLinkTap: _openTerms,
/// );
/// ```
class SintiaCheckOption extends StatefulWidget {
  const SintiaCheckOption({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
    this.linkText,
    this.onLinkTap,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  /// Texto resaltado al final de [label] que actúa como enlace.
  final String? linkText;
  final VoidCallback? onLinkTap;

  @override
  State<SintiaCheckOption> createState() => _SintiaCheckOptionState();
}

class _SintiaCheckOptionState extends State<SintiaCheckOption> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () => widget.onLinkTap?.call();
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? linkText = widget.linkText;
    final TextStyle? labelStyle = context.textTheme.bodyLarge?.semiBold;

    return Semantics(
      checked: widget.value,
      child: GestureDetector(
        onTap: () => widget.onChanged(!widget.value),
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: SintiaSpacing.small,
          children: <Widget>[
            _SintiaCheckCircle(value: widget.value),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: widget.label,
                  style: labelStyle,
                  children: <InlineSpan>[
                    if (linkText != null) ...<InlineSpan>[
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: linkText,
                        style: labelStyle?.primary(context),
                        recognizer: _recognizer,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Indicador circular de selección.
class _SintiaCheckCircle extends StatelessWidget {
  const _SintiaCheckCircle({required this.value});

  final bool value;

  /// Grosor del borde del círculo.
  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final Color primary = context.colorScheme.primary;
    return Container(
      width: SintiaSizes.size24,
      height: SintiaSizes.size24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value ? primary : Colors.transparent,
        border: Border.all(
          color: value ? primary : context.colorScheme.outline,
          width: _borderWidth,
        ),
      ),
      child: value
          ? Icon(
              Icons.check,
              size: SintiaIconSize.small,
              color: context.colorScheme.onPrimary,
            )
          : null,
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con enlace', group: 'SintiaCheckOption')
Widget sintiaCheckOptionPreview() => SintiaCheckOption(
  value: true,
  onChanged: (_) {},
  label: 'Acepto los',
  linkText: 'Términos y condiciones',
  onLinkTap: () {},
);
// coverage:ignore-end
