import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

/// Lista desplazable con el ancho máximo y el padding estándar del
/// showcase.
class ShowcaseList extends StatelessWidget {
  const ShowcaseList({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: SintiaBreakpoints.tablet),
        child: ListView.separated(
          padding: const EdgeInsets.all(SintiaSpacing.large),
          itemCount: children.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: SintiaSpacing.large),
          itemBuilder: (_, int index) => children[index],
        ),
      ),
    );
  }
}
