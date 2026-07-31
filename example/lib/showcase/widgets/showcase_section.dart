import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

/// Sección del showcase: título, descripción opcional y las variantes del
/// componente dispuestas en un [Wrap].
class ShowcaseSection extends StatelessWidget {
  const ShowcaseSection({
    required this.title,
    required this.children,
    super.key,
    this.description,
    this.stacked = false,
  });

  final String title;
  final String? description;
  final List<Widget> children;

  /// Apila las variantes en columna en lugar de envolverlas en fila.
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    final String? description = this.description;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: SintiaSpacing.small,
      children: <Widget>[
        SintiaText(title, style: context.textTheme.titleMedium?.semiBold),
        if (description != null)
          SintiaText(
            description,
            style: context.textTheme.bodySmall?.muted(context),
          ),
        const SizedBox(height: SintiaSpacing.extraSmall),
        if (stacked)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: SintiaSpacing.medium,
            children: children,
          )
        else
          Wrap(
            spacing: SintiaSpacing.medium,
            runSpacing: SintiaSpacing.medium,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
      ],
    );
  }
}
