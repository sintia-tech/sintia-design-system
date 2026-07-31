import 'package:flutter/material.dart';

import '../models/sintia_app_bar_action.dart';
import '../models/sintia_nav_item.dart';
import '../organisms/sintia_app_bar.dart';
import '../organisms/sintia_navigation_drawer.dart';
import '../theme/extensions/sintia_responsive_context_extension.dart';
import '../tokens/sintia_nav_drawer_metrics.dart';

/// Plantilla maestra de las apps con menú lateral.
///
/// Orquesta el [SintiaNavigationDrawer] y el contenido, resolviendo por sí
/// misma el comportamiento responsivo y el estado de colapso:
///
/// * **Escritorio y tablet**: el drawer es permanente y colapsable (rail).
/// * **Móvil**: el drawer se abre como modal desde el botón de menú de la
///   app bar y se cierra al elegir una ruta.
///
/// Es pura: no navega. Recibe la ruta activa y notifica la selección, así
/// que funciona igual con GoRouter, Navigator 1.0 o un `IndexedStack`.
///
/// ```dart
/// SintiaShellTemplate(
///   logo: Image.asset('assets/logo.png', height: 32),
///   mark: Image.asset('assets/isotipo.png', height: 32),
///   items: navItems,
///   footerItems: <SintiaNavItem>[settingsItem, logoutItem],
///   currentRoute: state.uri.path,
///   onRouteSelected: context.go,
///   body: child,
/// );
/// ```
class SintiaShellTemplate extends StatefulWidget {
  const SintiaShellTemplate({
    required this.items,
    required this.currentRoute,
    required this.onRouteSelected,
    required this.body,
    super.key,
    this.footerItems = const <SintiaNavItem>[],
    this.logo,
    this.mark,
    this.drawerHeader,
    this.drawerFooter,
    this.appBar,
    this.title,
    this.actions = const <SintiaAppBarAction>[],
    this.showAppBar = true,
    this.initiallyCollapsed = true,
    this.floatingActionButton,
  });

  /// Ítems principales del menú.
  final List<SintiaNavItem> items;

  /// Ítems secundarios anclados al final del menú.
  final List<SintiaNavItem> footerItems;

  /// Ruta activa, usada para marcar el ítem seleccionado y, si no se pasa
  /// [title], para titular la app bar.
  final String currentRoute;

  final ValueChanged<String> onRouteSelected;

  /// Contenido de la ruta activa.
  final Widget body;

  /// Logo completo del drawer (visible expandido).
  final Widget? logo;

  /// Versión compacta del logo (visible colapsado).
  final Widget? mark;

  /// Reemplaza por completo el encabezado del drawer.
  final Widget? drawerHeader;

  /// Contenido extra al final del drawer (por ejemplo, el usuario activo).
  final Widget? drawerFooter;

  /// App bar personalizada. Si es null se construye una con [title] (o la
  /// etiqueta del ítem activo) y [actions].
  final PreferredSizeWidget? appBar;

  /// Título de la app bar. Si es null usa la etiqueta del ítem activo.
  final String? title;

  final List<SintiaAppBarAction> actions;

  /// Permite prescindir de la app bar en escritorio. En móvil siempre se
  /// muestra: es la única vía para abrir el menú.
  final bool showAppBar;

  /// Estado inicial del drawer en pantallas grandes.
  final bool initiallyCollapsed;

  final Widget? floatingActionButton;

  @override
  State<SintiaShellTemplate> createState() => _SintiaShellTemplateState();
}

class _SintiaShellTemplateState extends State<SintiaShellTemplate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late bool _collapsed = widget.initiallyCollapsed;

  void _toggleCollapsed() => setState(() => _collapsed = !_collapsed);

  /// Etiqueta del ítem cuya ruta está activa, para titular la app bar.
  String? get _currentLabel {
    for (final SintiaNavItem item in <SintiaNavItem>[
      ...widget.items,
      ...widget.footerItems,
    ]) {
      if (item.route == widget.currentRoute) return item.label;
    }
    return null;
  }

  void _onItemSelected({required SintiaNavItem item, required bool isMobile}) {
    if (isMobile) _scaffoldKey.currentState?.closeDrawer();
    widget.onRouteSelected(item.route);
  }

  PreferredSizeWidget? _appBar({required bool isMobile}) {
    final PreferredSizeWidget? appBar = widget.appBar;
    if (appBar != null) return appBar;
    if (!widget.showAppBar && !isMobile) return null;
    return SintiaAppBar(
      title: widget.title ?? _currentLabel ?? '',
      leading: isMobile ? SintiaAppBarLeading.menu : SintiaAppBarLeading.none,
      actions: widget.actions,
    );
  }

  Widget _drawer({required bool isMobile}) {
    return SintiaNavigationDrawer(
      items: widget.items,
      footerItems: widget.footerItems,
      currentRoute: widget.currentRoute,
      logo: widget.logo,
      mark: widget.mark,
      header: widget.drawerHeader,
      footer: widget.drawerFooter,
      collapsed: !isMobile && _collapsed,
      onToggleCollapsed: isMobile ? null : _toggleCollapsed,
      showBorder: !isMobile,
      onItemSelected: (SintiaNavItem item) =>
          _onItemSelected(item: item, isMobile: isMobile),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    if (isMobile) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(isMobile: true),
        drawer: Drawer(
          width: SintiaNavDrawerMetrics.expandedWidth,
          child: _drawer(isMobile: true),
        ),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: <Widget>[
          _drawer(isMobile: false),
          Expanded(
            child: Scaffold(
              appBar: _appBar(isMobile: false),
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
            ),
          ),
        ],
      ),
    );
  }
}
