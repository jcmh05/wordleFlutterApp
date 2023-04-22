import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordle/funcionalidades/opciones_de_juego.dart';
import 'package:wordle/datos_de_juego/palabras_wordle.dart';


// Clase que representa el estado del juego.
class EstadoDeJuego {
  // Propiedades de solo lectura.
  final OpcionesDeJuego opciones; // Objeto que contiene las opciones del juego.
  final List<String> palabras_validas; // Lista de palabras válidas.
  final String palabraCorrecta; // Palabra correcta.
  final List<String> intentos; // Lista de intentos.
  final int attempted; // Número de intentos realizados.

  // Constructor constante que inicializa todas las propiedades de solo lectura.
  const EstadoDeJuego({
    required this.palabras_validas, // Lista de palabras válidas.
    required this.palabraCorrecta, // Palabra correcta.
    required this.opciones, // Objeto que contiene las opciones del juego.
    required this.intentos, // Lista de intentos.
    required this.attempted, // Número de intentos realizados.
  });

  // Método que clona la instancia actual de EstadoDeJuego y devuelve una nueva instancia
  // con las propiedades actualizadas.
  EstadoDeJuego clone({
    List<String>? validWords, // Lista de palabras válidas actualizadas.
    String? correctWord, // Palabra correcta actualizada.
    List<String>? attempts, // Lista de intentos actualizada.
    int? attempted, // Número de intentos actualizado.
  }) {
    return EstadoDeJuego(
      palabras_validas: validWords ?? this.palabras_validas, // Si la lista de palabras válidas no está actualizada, se utiliza la lista actual.
      palabraCorrecta: correctWord ?? this.palabraCorrecta, // Si la palabra correcta no está actualizada, se utiliza la palabra actual.
      opciones: this.opciones, // Las opciones del juego no cambian.
      attempted: attempted ?? this.attempted, // Si el número de intentos no está actualizado, se utiliza el número actual.
      intentos: attempts ?? this.intentos, // Si la lista de intentos no está actualizada, se utiliza la lista actual.
    );
  }
}

// Clase que extiende StateNotifier y representa el controlador de estado del juego.
class EstadoDeJuegoNotifier extends StateNotifier<EstadoDeJuego> {
  final Random rng = Random(); // Generador de números aleatorios.

  // Constructor que toma un objeto OpcionesDeJuego como parámetro y establece el estado inicial del juego.
  EstadoDeJuegoNotifier(OpcionesDeJuego settings)
      : super(EstadoDeJuego(
    palabras_validas: [], // La lista de palabras válidas comienza vacía.
    palabraCorrecta: "begin", // La palabra correcta inicial es "begin".
    opciones: settings, // Las opciones del juego se establecen según el objeto OpcionesDeJuego proporcionado.
    intentos: [], // La lista de intentos comienza vacía.
    attempted: 0, // El número de intentos realizados comienza en cero.
  ));

// Método asincrónico que carga una lista de palabras y actualiza el estado del juego con estas palabras.
  Future<void> actualizarPalabras() async {
    final words = await loadWords(state.opciones.tam_palabra); // Carga una lista de palabras de acuerdo con el tamaño de palabra especificado en las opciones del juego.
    state = state.clone( // Clona la instancia actual del estado y actualiza la lista de palabras válidas y la palabra correcta.
      validWords: words, // La lista de palabras válidas se actualiza con la lista cargada.
      correctWord: words[rng.nextInt(words.length - 1)], // La palabra correcta se actualiza con una palabra aleatoria de la lista cargada.
    );
  }

  // Método que elige una nueva palabra correcta al azar de la lista de palabras válidas
  // en el estado actual del juego.
  void nuevaPalabraCorrecta() {
    state = state.clone( // Clona la instancia actual del estado y actualiza la palabra correcta con una nueva palabra aleatoria de la lista de palabras válidas.
      correctWord: state.palabras_validas[rng.nextInt(state.palabras_validas.length - 1)],
    );
  }

  // Método que actualiza el intento actual del jugador.
  void actualizarIntentoActual(String key) {
    final intentos = state.intentos; // Obtiene la lista actual de intentos del estado.
    if (intentos.length <= state.attempted) { // Si el número de intentos realizados es menor o igual al número de intentos registrados, agrega un nuevo elemento a la lista de intentos.
      intentos.add("");
    }
    var intentoActual = intentos[state.attempted]; // Obtiene el intento actual del jugador.

    if (key == "_") { // Si la tecla presionada es "_", significa que el jugador ha presionado Enter para enviar el intento.
      // handle enter press

      if (intentoActual.length < state.opciones.tam_palabra) { // Si la longitud del intento actual es menor que la longitud de palabra especificada en las opciones del juego, muestra un mensaje de error y devuelve la función.
        print("La palabra no tiene el tamaño necesario");
        return;
      }

      if (!state.palabras_validas.contains(intentoActual)) { // Si el intento actual no se encuentra en la lista de palabras válidas, muestra un mensaje de error y devuelve la función.
        print("Palabra no válida");
        return;
      }

      state = state.clone(attempted: state.attempted + 1); // Si el intento actual es válido, actualiza el número de intentos realizados en el estado.
    } else if (key == "<") { // Si la tecla presionada es "<", significa que el jugador ha presionado la tecla de retroceso para borrar el último carácter del intento actual.
      // handle backpress
      if (intentoActual.isEmpty) { // Si el intento actual está vacío, muestra un mensaje de error y devuelve la función.
        print("No puedes borrar más");
        return;
      }
      intentoActual = intentoActual.substring(0, intentoActual.length - 1); // Borra el último carácter del intento actual.
      intentos[state.attempted] = intentoActual; // Actualiza la lista de intentos con el intento actual modificado.
      state = state.clone(attempts: intentos); // Actualiza el estado con la lista de intentos actualizada.
    } else { // Si la tecla presionada no es "_" ni "<", significa que el jugador ha presionado una letra para agregarla al intento actual.
      if (intentoActual.length >= state.opciones.tam_palabra) { // Si la longitud del intento actual es mayor o igual que la longitud de palabra especificada en las opciones del juego, muestra un mensaje de error y devuelve la función.
        print("trying to type word longer than correct word length");
        return;
      }
      intentoActual += key; // Agrega la letra presionada al intento actual.
      intentos[state.attempted] = intentoActual; // Actualiza la lista de intentos con el intento actual modificado.
      state = state.clone(attempts: intentos); // Actualiza el estado con la lista de intentos actualizada.
    }
  }
}

// Crea un proveedor de estado para el juego.
final gameStateProvider =
StateNotifierProvider<EstadoDeJuegoNotifier, EstadoDeJuego>((ref) {
  final settings = ref.watch(gameSettingsProvider); // Obtiene las opciones de juego actuales del proveedor de opciones de juego.
  final gameStateNotifier = EstadoDeJuegoNotifier(settings); // Crea una nueva instancia del notificador de estado de juego con las opciones de juego actuales.
  gameStateNotifier.actualizarPalabras(); // Carga una nueva lista de palabras para el juego en la instancia recién creada del notificador de estado de juego.
  return gameStateNotifier; // Devuelve la instancia del notificador de estado de juego con la lista de palabras actualizada como el proveedor de estado del juego.
});