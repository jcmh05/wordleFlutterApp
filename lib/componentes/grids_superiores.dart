import 'package:flutter/material.dart';
import 'package:com.jc.wordel/componentes/componentes.dart';
import 'package:com.jc.wordel/funciones/funciones.dart';
import 'package:fluttertoast/fluttertoast.dart';


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

  // Muestra un toast informativo por pantalla
  void mostrarMensaje(String mensaje) {
    Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

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
          }else{
            if( indice == 0 || (indice) == letrasFilaActual.length){
              return CasillaDeLetra( letra: " ", estadoCasilla: 4);
            }
          }
        }else{
          if( index < letrasComprobadas.length ){
            // Si se están dibujando las casillas anteriores a la fila actual
            var indice = index % numero_columnas;

            String palabraIntroducida = "";
            for(int i=0; i<palabra.length; i++){
              palabraIntroducida += letrasComprobadas[(index-indice)+i].toLowerCase();
            }
            int color = devolverColor(palabra, palabraIntroducida, indice);
            return CasillaDeLetra( letra: letrasComprobadas[index], estadoCasilla: color,);
          }
        }

        return CasillaDeLetra(letra: " ",estadoCasilla: 0,);
      },
    );
  }
}