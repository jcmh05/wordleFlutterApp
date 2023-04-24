import 'package:flutter/material.dart';
import 'package:wordle/componentes/componentes.dart';


class GridsSuperiores extends StatelessWidget {
  final int numero_columnas;
  final String palabra;
  final List<String> letrasComprobadas;

  // letras y filaActual se usarán para dibujar la palabra que se está escribiendo
  final List<String> letrasFilaActual;
  final int filaActual;

  const GridsSuperiores({
    Key? key,
    required this.numero_columnas,
    required this.letrasComprobadas,
    required this.letrasFilaActual,
    required this.palabra,
    required this.filaActual
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parámetros grid
    int numero_filas = 6;
    if( numero_columnas==4 ){
      numero_filas = 5;
    }else if (numero_columnas==6){
      numero_filas = 7;
    }


    return GridView.builder(
      padding: EdgeInsets.all(15.0), //Espacio alrededor del GridView
      shrinkWrap: true,
      itemCount: numero_columnas * numero_filas, // Agregamos 2 para los espacios vacíos
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numero_columnas
      ),

      itemBuilder: (BuildContext context, int index) {

        if ( index>=(numero_columnas*filaActual) && index< (numero_columnas*(filaActual+1))){
          // Si se están dibujando las casillas de la fila actual
          var indice = index - numero_columnas*filaActual;
          if( indice < letrasFilaActual.length){
            return CasillaDeLetra( letra: letrasFilaActual[indice], estadoCasilla: 0,);
          }
        }else{
          if( index < letrasComprobadas.length ){
            // Si se están dibujando las casillas anteriores a la fila actual
            var indice = index % numero_columnas;
            if( letrasComprobadas[index] == palabra[indice].toUpperCase()){
              // Si la letra coincide con la letra de la palabra
              return CasillaDeLetra( letra: letrasComprobadas[index], estadoCasilla: 3,);
            }else{
              if (palabra.contains(letrasComprobadas[index].toLowerCase() ) ){
                // Si la letra no coincide pero está en la palabra
                return CasillaDeLetra( letra: letrasComprobadas[index], estadoCasilla: 2,);
              }else{
                // Si la letra no coincide ni está en la palabra
                return CasillaDeLetra( letra: letrasComprobadas[index], estadoCasilla: 1,);
              }
            }
            return CasillaDeLetra( letra: "A", estadoCasilla: 0,);
          }
        }

        return CasillaDeLetra(letra: " ",estadoCasilla: 0,);
      },
    );
  }
}