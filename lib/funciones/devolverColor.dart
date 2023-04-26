int devolverColor(String palabra, String palabraIntroducida, int posicion) {
  List<bool> verdes = List<bool>.filled(palabra.length, false);
  List<bool> amarillas = List<bool>.filled(palabra.length, false);
  Map<String, int> letraFrecuencia = {};

  // Calcular la frecuencia de las letras en la palabra
  for (int i = 0; i < palabra.length; i++) {
    if (letraFrecuencia.containsKey(palabra[i])) {
      letraFrecuencia[palabra[i]] = letraFrecuencia[palabra[i]]! + 1;
    } else {
      letraFrecuencia[palabra[i]] = 1;
    }
  }

  // Encontrar letras verdes
  for (int i = 0; i < palabra.length; i++) {
    if (palabra[i] == palabraIntroducida[i]) {
      verdes[i] = true;
      letraFrecuencia[palabra[i]] = letraFrecuencia[palabra[i]]! - 1;
    }
  }

  // Encontrar letras amarillas
  for (int i = 0; i < palabra.length; i++) {
    if (!verdes[i] &&
        letraFrecuencia.containsKey(palabraIntroducida[i]) &&
        letraFrecuencia[palabraIntroducida[i]]! > 0) {
      amarillas[i] = true;
      letraFrecuencia[palabraIntroducida[i]] =
          letraFrecuencia[palabraIntroducida[i]]! - 1;
    }
  }

  // Determinar el color correcto
  if (verdes[posicion]) {
    return 3; // Color verde
  } else if (amarillas[posicion]) {
    return 2; // Color amarillo
  } else {
    return 1; // Color gris
  }
}

