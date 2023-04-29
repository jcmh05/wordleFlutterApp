import 'package:flutter/material.dart';

class CasillaDeLetra extends StatelessWidget {
  final String letra;
  final tamano_letra = 0.8;
  final int estadoCasilla;

  const CasillaDeLetra({Key? key,required this.letra, required this.estadoCasilla}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // Propiedades para los estados de la casilla
    Color fondoCasilla = Colors.transparent;
    Color colorLetra = Theme.of(context).colorScheme.onSurface;
    Color colorBorde = Theme.of(context).dividerColor;

    // Cambiar colores en función del estado de la casilla
    switch (estadoCasilla) {
      case 1: // Letra no está en la palabra
        fondoCasilla = Color(0xFF787C7F);
        colorLetra = Colors.white;
        break;
      case 2: // Letra está pero en otra posición
        fondoCasilla = Color(0xFFc9b457);
        colorLetra = Colors.white;
        break;
      case 3: // Letra está en posición correcta
        fondoCasilla = Color(0xFF6baa65);
        colorLetra = Colors.white;
        break;
      case 4: // Siguiente letra en dibujarse
        colorBorde = Theme.of(context).accentColor;
        break;
    }


    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: fondoCasilla,
            border: Border.all(color: colorBorde, width: 2)
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                letra,
                style: TextStyle(
                  color: colorLetra,
                  fontSize: constraints.maxHeight * tamano_letra,
                ),
              ),
            ),
          )
        );
      },
    );
  }
}