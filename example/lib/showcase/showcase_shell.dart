import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../catalog/catalog.dart';
import '../catalog/component_category.dart';
import 'category_page.dart';
import 'welcome_page.dart';

/// Estructura principal del showcase.
///
/// Usa la propia plantilla maestra del sistema ([SintiaShellTemplate]), así
/// que el drawer colapsable y el comportamiento responsivo del showcase son
/// los mismos que obtiene cualquier app consumidora.
class ShowcaseShell extends StatefulWidget {
  const ShowcaseShell({
    required this.isDark,
    required this.onToggleTheme,
    super.key,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  State<ShowcaseShell> createState() => _ShowcaseShellState();
}

class _ShowcaseShellState extends State<ShowcaseShell> {
  static const String _welcomeRoute = '/';

  String _route = _welcomeRoute;

  static final List<SintiaNavItem> _items = <SintiaNavItem>[
    const SintiaNavItem(
      label: 'Bienvenida',
      icon: Icons.auto_awesome_outlined,
      selectedIcon: Icons.auto_awesome,
      route: _welcomeRoute,
    ),
    for (final ComponentCategory category in catalog)
      SintiaNavItem(
        label: category.title,
        icon: category.icon,
        route: category.route,
      ),
  ];

  ComponentCategory? get _category {
    for (final ComponentCategory category in catalog) {
      if (category.route == _route) return category;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final ComponentCategory? category = _category;

    return SintiaShellTemplate(
      items: _items,
      currentRoute: _route,
      onRouteSelected: (String route) => setState(() => _route = route),
      logo: const _ShowcaseLogo(),
      mark: const _ShowcaseMark(),
      title: category?.title ?? 'Sintia Design System',
      actions: <SintiaAppBarAction>[
        SintiaAppBarAction(
          icon: widget.isDark
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          tooltip: widget.isDark ? 'Tema claro' : 'Tema oscuro',
          onPressed: widget.onToggleTheme,
        ),
      ],
      body: category == null
          ? WelcomePage(
              onExplore: () => setState(() => _route = catalog.first.route),
            )
          : CategoryPage(category: category),
    );
  }
}

/// Logotipo del showcase con el drawer expandido.
class _ShowcaseLogo extends StatelessWidget {
  const _ShowcaseLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: SintiaSpacing.small,
      children: <Widget>[
        const _ShowcaseMark(),
        SintiaText(
          'Sintia',
          style: context.textTheme.titleLarge?.bold,
        ),
      ],
    );
  }
}

/// Isotipo del showcase con el drawer colapsado.
class _ShowcaseMark extends StatelessWidget {
  const _ShowcaseMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SintiaSizes.size32,
      height: SintiaSizes.size32,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: SintiaRadius.borderSmall,
      ),
      child: Center(
        child: SintiaText(
          'S',
          style: context.textTheme.titleMedium?.bold.withColor(
            context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
