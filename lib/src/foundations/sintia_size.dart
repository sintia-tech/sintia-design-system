/// Vocabulario de tamaños del sistema de diseño.
///
/// Foundation sin valores: nombra los tamaños con los que habla el sistema,
/// pero no decide dimensiones. Cada componente traduce este vocabulario a
/// valores crudos de `SintiaSizes` según su propia proporción (un `small` de
/// avatar no mide lo mismo que un `small` de loader).
enum SintiaSize {
  small,
  medium,
  large,
}
