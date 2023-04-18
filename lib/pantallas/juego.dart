import 'package:flutter/material.dart';
import '../componentes/componentes.dart';

class Juego extends StatefulWidget{
  final int modoDeJuego;
  const Juego({Key? key, required this.modoDeJuego}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JuegoState();

}

class _JuegoState extends State<Juego> {

  String teclasPulsadas = " ";


  @override
  Widget build( BuildContext context) {
    final teclaPulsada = (String tecla) {
      setState(() {
        if( tecla == "BORRAR"){
          teclasPulsadas = " ";
        }else{
          teclasPulsadas = teclasPulsadas + tecla + " ";
        }
      });
    };

    return Column(
      children: [
        //Matriz de casillas
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1), // Agregar padding horizontal
            child: GridsSuperiores(modoDeJuego: widget.modoDeJuego),
          ),
        ),
        //Prueba de teclado
        SizedBox(height: 15.0),

        //Teclado
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1), // Agregar padding horizontal

            child: Keyboard(TeclaPulsada: teclaPulsada),
          ),

        SizedBox(height: 15.0), //Agregar espacio entre el teclado y el borde inferior de la pantalla
      ],
    );
  }
}