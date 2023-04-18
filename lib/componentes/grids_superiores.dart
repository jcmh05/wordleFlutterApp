import 'package:flutter/material.dart';
import 'package:wordle/componentes/componentes.dart';


class GridsSuperiores extends StatelessWidget {
  final int numero_columnas;
  final List<String?> letras;
  const GridsSuperiores({Key? key, required this.numero_columnas, required this.letras}) : super(key: key);

  final filaActual = 0;

  @override
  Widget build(BuildContext context) {
    // Parámetros grid
    final numero_filas = 6;

    return GridView.builder(
      padding: EdgeInsets.all(15.0), //Espacio alrededor del GridView
      shrinkWrap: true,
      itemCount: numero_columnas * numero_filas, // Agregamos 2 para los espacios vacíos
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: numero_columnas,
      ),
      itemBuilder: (BuildContext context, int index) {

        if ( index>=(numero_columnas*filaActual) && index< (numero_columnas*(filaActual+1))){
          var indice = index - numero_columnas*filaActual;
          if( indice < letras.length){
            return CasillaDeLetra(anchura: 5.0,altura: 5.0, letra: letras[indice]!,);
          }


        }

        return CasillaDeLetra(anchura: 5.0,altura: 5.0, letra: " ",);
      },
    );
  }
}