import 'package:flutter/material.dart';
import 'package:wordle/componentes/grids_superiores.dart';
import '../componentes/componentes.dart';

class PantallaJuego extends StatefulWidget{

  const PantallaJuego({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PantallaJuegoState();

}

class _PantallaJuegoState extends State<PantallaJuego> {

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
        GridsSuperiores(),
        //Prueba de teclado
        SizedBox(height: 15.0),
        Text('Teclas Pulsadas: ', style: TextStyle(fontSize: 24)),
        Text(  teclasPulsadas,style: TextStyle(fontSize: 20)),

        //Teclado
        Keyboard(TeclaPulsada: teclaPulsada),
      ],
    );
  }
}