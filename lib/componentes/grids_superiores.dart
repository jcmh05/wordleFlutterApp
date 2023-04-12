import 'package:flutter/material.dart';
import 'package:wordle/componentes/componentes.dart';


const filas=6;
const tam_palabra=5;

class GridsSuperiores extends StatelessWidget {
  const GridsSuperiores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Row> filas_palabra=List.empty(growable: true);

    for(int i=0;i < filas;i++){

      final List<CasillaDeLetra> casillas = List.empty(growable: true);

      for(int j=0; j<tam_palabra;j++){

        casillas.add(CasillaDeLetra());
      }

      filas_palabra.add(
          Row(
          mainAxisSize: MainAxisSize.min,
          children: casillas,
          ));
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: filas_palabra,
      ),
    );
  }
}

