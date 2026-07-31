import 'package:flutter/material.dart';

import '../atoms/sintia_icon_action.dart';
import '../models/sintia_app_bar_action.dart';
import '../molecules/sintia_app_bar_title.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';

/// Tipo de widget inicial de la [SintiaAppBar].
enum SintiaAppBarLeading {
  /// Sin widget inicial: el título se alinea al inicio.
  none,

  /// Botón de volver. Por defecto hace `Navigator.pop`.
  back,

  /// Botón de menú. Por defecto abre el drawer del `Scaffold`; si el
  /// `Scaffold` no tiene drawer, el botón no se dibuja.
  menu,
}

/// App bar del sistema de diseño.
///
/// Organismo que une el título ([SintiaAppBarTitle]) y las acciones
/// ([SintiaIconAction]) sobre el `AppBar` de Material, que ya hereda color,
/// tipografía y elevación de `SintiaTheme`.
///
/// ```dart
/// // Pantalla principal con título táctil y carrito con badge.
/// SintiaAppBar(
///   title: 'Tienda el Centro',
///   titleSuffix: const Icon(Icons.keyboard_arrow_down),
///   onTitlePressed: _openStorePicker,
///   actions: <SintiaAppBarAction>[
///     SintiaAppBarAction(
///       icon: Icons.shopping_cart_outlined,
///       badgeCount: 3,
///       tooltip: 'Carrito',
///       onPressed: _openCart,
///     ),
///   ],
/// );
///
/// // Pantalla interna con botón de volver.
/// SintiaAppBar(
///   title: 'Detalle del producto',
///   leading: SintiaAppBarLeading.back,
/// );
/// ```
class SintiaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SintiaAppBar({
    required this.title,
    super.key,
    this.leading = SintiaAppBarLeading.none,
    this.onLeadingPressed,
    this.actions = const <SintiaAppBarAction>[],
    this.onTitlePressed,
    this.titlePrefix,
    this.titleSuffix,
    this.centerTitle,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  final String title;

  /// Widget inicial. Ver [SintiaAppBarLeading].
  final SintiaAppBarLeading leading;

  /// Sobreescribe la acción por defecto del widget inicial.
  final VoidCallback? onLeadingPressed;

  /// Acciones finales, declaradas como datos.
  final List<SintiaAppBarAction> actions;

  /// Si no es null, el título completo es táctil.
  final VoidCallback? onTitlePressed;
  final Widget? titlePrefix;
  final Widget? titleSuffix;

  /// Si es null, el título se centra solo cuando hay widget inicial.
  final bool? centerTitle;

  /// Widget bajo la app bar (tabs, buscador…).
  final PreferredSizeWidget? bottom;

  /// Overrides para casos excepcionales; por defecto todo sale del tema.
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  bool get _hasLeading => leading != SintiaAppBarLeading.none;

  bool get _centerTitle => centerTitle ?? _hasLeading;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  Widget? _buildLeading(BuildContext context) {
    switch (leading) {
      case SintiaAppBarLeading.none:
        return null;
      case SintiaAppBarLeading.back:
        return SintiaIconAction(
          icon: Icons.arrow_back,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: onLeadingPressed ?? () => Navigator.of(context).maybePop(),
        );
      case SintiaAppBarLeading.menu:
        final ScaffoldState? scaffold = Scaffold.maybeOf(context);
        final VoidCallback? onPressed =
            onLeadingPressed ??
            (scaffold?.hasDrawer ?? false ? scaffold!.openDrawer : null);
        if (onPressed == null) return null;
        return SintiaIconAction(
          icon: Icons.menu,
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          onPressed: onPressed,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color foreground = foregroundColor ?? context.colorScheme.onSurface;

    return AppBar(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      automaticallyImplyLeading: false,
      centerTitle: _centerTitle,
      leading: _buildLeading(context),
      bottom: bottom,
      title: SintiaAppBarTitle(
        text: title,
        style: context.theme.appBarTheme.titleTextStyle?.copyWith(
          color: foreground,
        ),
        prefix: titlePrefix,
        suffix: titleSuffix,
        onPressed: onTitlePressed,
      ),
      actions: <Widget>[
        for (final SintiaAppBarAction action in actions)
          SintiaIconAction(
            icon: action.icon,
            onPressed: action.onPressed,
            tooltip: action.tooltip,
            badgeCount: action.badgeCount,
            color: foreground,
          ),
      ],
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Principal', group: 'SintiaAppBar')
Widget sintiaAppBarHomePreview() => Scaffold(
  appBar: SintiaAppBar(
    title: 'Tienda el Centro',
    titleSuffix: const Icon(Icons.keyboard_arrow_down),
    onTitlePressed: () {},
    actions: <SintiaAppBarAction>[
      SintiaAppBarAction(
        icon: Icons.shopping_cart_outlined,
        tooltip: 'Carrito',
        badgeCount: 3,
        onPressed: () {},
      ),
    ],
  ),
);

@SintiaPreview(name: 'Con volver', group: 'SintiaAppBar')
Widget sintiaAppBarBackPreview() => Scaffold(
  appBar: SintiaAppBar(
    title: 'Detalle del producto',
    leading: SintiaAppBarLeading.back,
    onLeadingPressed: () {},
    actions: <SintiaAppBarAction>[
      SintiaAppBarAction(
        icon: Icons.search,
        tooltip: 'Buscar',
        onPressed: () {},
      ),
    ],
  ),
);
// coverage:ignore-end
