/// Assets empaquetados dentro del sistema de diseño.
///
/// Interno al paquete: los assets se declaran en el `pubspec.yaml` del
/// propio sistema, por lo que las apps consumidoras no necesitan declarar
/// nada. Al cargarlos hay que pasar [package] para que Flutter los resuelva
/// desde este paquete y no desde la app.
abstract final class SintiaAssets {
  /// Nombre del paquete, requerido por `Lottie.asset` e `Image.asset`.
  static const String package = 'sintia_design_system';

  /// Animación del indicador de carga (`SintiaLoader`).
  static const String loadingAnimation = 'assets/animations/loading.json';
}
