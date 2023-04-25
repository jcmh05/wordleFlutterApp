int devolverColor(String palabra, String palabraIntroducida, int posicion) {
  // Comprobar si la letra está en la posición correcta
  if (palabra[posicion] == palabraIntroducida[posicion]) {
    return 3; // Color verde
  }

  // Si la letra no está en la posición correcta, comprobar si está en la palabra
  Map<String, int> letraFrecuencia = {};

  for (int i = 0; i < palabra.length; i++) {
    if (letraFrecuencia.containsKey(palabra[i])) {
      letraFrecuencia[palabra[i]] = letraFrecuencia[palabra[i]]! + 1;
    } else {
      letraFrecuencia[palabra[i]] = 1;
    }
  }

  if (letraFrecuencia.containsKey(palabraIntroducida[posicion]) &&
      letraFrecuencia[palabraIntroducida[posicion]]! > 0) {
    letraFrecuencia[palabraIntroducida[posicion]] =
        letraFrecuencia[palabraIntroducida[posicion]]! - 1;
    return 2; // Color amarillo
  }

  return 1; // Color gris
}

