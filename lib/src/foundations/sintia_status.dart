/// Estados semánticos del sistema de diseño.
///
/// Vocabulario compartido por los componentes que comunican estado
/// (banners, badges, chips de estado). Cada valor se resuelve a color vía
/// `SintiaStatusColors` (o `ColorScheme.error` para [error]), nunca a
/// colores hardcodeados.
enum SintiaStatus {
  /// Información neutral.
  info,

  /// Operación exitosa.
  success,

  /// Advertencia que requiere atención.
  warning,

  /// Error o acción destructiva.
  error,
}
