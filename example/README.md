# Showcase — Sintia System Design

App navegable con todos los tokens y componentes del sistema de diseño,
construida con la propia `SintiaShellTemplate`.

```bash
flutter run -d chrome   # o -d macos, un emulador, etc.
flutter test
```

## Cómo está organizada

```
lib/
├── main.dart                # inyecta la marca y las fuentes (ShowcaseApp)
├── catalog/                 # catálogo: categorías y entradas navegables
├── showcase/                # shell con drawer, bienvenida y listado
│   └── widgets/             # ShowcaseList, ShowcaseSection, ShowcasePage
└── pages/
    ├── tokens/              # colores, tipografía, espaciado
    ├── atoms/ molecules/ organisms/ templates/
    └── examples/            # páginas completas con datos reales
```

Las fuentes `Montserrat` y `OpenSans` se registran en el `pubspec.yaml` de esta
app y se pasan al sistema vía `SintiaThemeConfig`: el paquete es agnóstico a la
fuente y no empaqueta ninguna.

## Agregar una página

1. Crea el archivo en `lib/pages/<capa>/<nombre>_page.dart`, usando
   `ShowcaseList` + `ShowcaseSection`.
2. Regístralo como `ComponentEntry` en la categoría correspondiente de
   `lib/catalog/catalog.dart`.
