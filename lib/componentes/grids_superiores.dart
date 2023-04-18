import 'package:flutter/material.dart';
import 'package:wordle/componentes/componentes.dart';

const filas = 6;
const double tamanoMaxCasilla = 60.0;

class GridsSuperiores extends StatelessWidget {
  final int modoDeJuego;
  const GridsSuperiores({Key? key, required this.modoDeJuego}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double casillaAnchura = constraints.maxWidth / modoDeJuego;
        double tamanoMaximoSegunModo = constraints.maxWidth / modoDeJuego;
        casillaAnchura = casillaAnchura > tamanoMaxCasilla ? tamanoMaxCasilla : casillaAnchura;
        casillaAnchura = casillaAnchura > tamanoMaximoSegunModo ? tamanoMaximoSegunModo : casillaAnchura;
        double casillaAltura = casillaAnchura;

        final List<Row> filas_palabra = List.empty(growable: true);

        for (int i = 0; i < filas; i++) {
          final List<CasillaDeLetra> casillas = List.empty(growable: true);

          for (int j = 0; j < this.modoDeJuego; j++) {
            casillas.add(CasillaDeLetra(anchura: casillaAnchura, altura: casillaAltura));
          }

          filas_palabra.add(
            Row(
              mainAxisSize: MainAxisSize.min,
              children: casillas,
            ),
          );
        }

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: filas_palabra,
          ),
        );
      },
    );
  }
}