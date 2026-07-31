import 'package:flutter/material.dart';

import '../tokens/sintia_duration.dart';
import '../tokens/sintia_nav_drawer_metrics.dart';
import '../tokens/sintia_spacing.dart';

/// Encabezado de marca del [SintiaNavigationDrawer].
///
/// Cruza dos versiones del logo según el estado del drawer: [logo] cuando
/// está expandido y [mark] (versión compacta, típicamente el isotipo)
/// cuando está colapsado. Si no se pasa [mark], usa [logo] en ambos.
///
/// El contenido se maqueta siempre con el ancho expandido y se recorta al
/// colapsar, para que no haya overflow durante la animación de ancho.
///
/// ```dart
/// SintiaNavDrawerHeader(
///   collapsed: collapsed,
///   logo: Image.asset('assets/logo.png', height: 32),
///   mark: Image.asset('assets/isotipo.png', height: 32),
/// );
/// ```
class SintiaNavDrawerHeader extends StatelessWidget {
  const SintiaNavDrawerHeader({
    required this.logo,
    required this.collapsed,
    super.key,
    this.mark,
  });

  /// Logo completo, visible con el drawer expandido.
  final Widget logo;

  /// Versión compacta del logo, visible con el drawer colapsado.
  final Widget? mark;

  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SintiaNavDrawerMetrics.headerHeight,
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.centerLeft,
          minWidth: SintiaNavDrawerMetrics.expandedWidth,
          maxWidth: SintiaNavDrawerMetrics.expandedWidth,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _Fade(
                visible: collapsed,
                child: SizedBox(
                  width: SintiaNavDrawerMetrics.collapsedWidth,
                  child: Center(child: mark ?? logo),
                ),
              ),
              _Fade(
                visible: !collapsed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SintiaSpacing.medium,
                  ),
                  child: Align(alignment: Alignment.centerLeft, child: logo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Capa que aparece o desaparece con la animación del drawer, sin recibir
/// toques cuando está oculta.
class _Fade extends StatelessWidget {
  const _Fade({required this.visible, required this.child});

  final bool visible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        duration: SintiaDuration.normal,
        curve: Curves.easeInOut,
        opacity: visible ? 1 : 0,
        child: Align(alignment: Alignment.centerLeft, child: child),
      ),
    );
  }
}
