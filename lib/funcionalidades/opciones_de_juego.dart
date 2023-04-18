import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importación del paquete 'flutter_riverpod' para utilizar el proveedor de estado

class OpcionesDeJuego {
  final int tam_palabra;
  final int intentos;

  OpcionesDeJuego({required this.tam_palabra, required this.intentos});

// Método clone de la clase 'OpcionesDeJuego' que devuelve una nueva instancia de la clase 'OpcionesDeJuego' con valores actualizados.
  OpcionesDeJuego clone({int? tam_palabra, int? intentos}) {
    return OpcionesDeJuego(
        intentos: intentos ?? this.intentos,
        tam_palabra: tam_palabra ?? this.tam_palabra);
  }
}

class OpcionesDeJuegoNotifier extends StateNotifier<OpcionesDeJuego> {
  OpcionesDeJuegoNotifier() : super(OpcionesDeJuego(tam_palabra: 5, intentos: 6));

  void actualizarIntentos(int intentos) {
    state = state.clone(intentos: intentos);
  }

  void actualizarTamPalabra(int tam_palabra) {
    state = state.clone(tam_palabra: tam_palabra);
  }
}

final gameSettingsProvider =
StateNotifierProvider<OpcionesDeJuegoNotifier, OpcionesDeJuego>((ref) {
  return OpcionesDeJuegoNotifier();
});









