import 'package:flutter/material.dart';
import '../componentes/componentes.dart';

class Juego extends StatefulWidget{

  const Juego({Key? key}) : super(key: key);

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
          child: GridsSuperiores(),
        ),
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