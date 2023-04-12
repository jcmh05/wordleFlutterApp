import 'package:flutter/material.dart';
import './componentes.dart';

class Keyboard extends StatefulWidget{
  final Function(String) TeclaPulsada;
  const Keyboard({Key? key, required this.TeclaPulsada}) : super( key: key);

  @override
  State<Keyboard> createState() => _KeyboardState(TeclaPulsada: TeclaPulsada);
}

class _KeyboardState extends State<Keyboard> {
  //Función anónima que informa a la pantalla_juego de que tecla ha sido pulsada
  final Function(String) TeclaPulsada;
  // Teclas máximas que puede haber por fila en el teclado
  final teclasPorFila = 10;
  // Espacio entre las distintas filas del teclado
  final separacion = 15.0;
  // Teclas correspondientes al teclado en español
  final tecladoEspanol = ['Q','W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Ñ','Z','X','C','V','B','N','M','BORRAR'];

  _KeyboardState({required this.TeclaPulsada});

  @override void initState() {
    // TODO: implement initState
    super.initState();
  }


  List<Widget> columnasTeclas(){
    final columnas = <Widget>[];
    int letra = 0;
    for(int i=0; i<3; i++){
      columnas.add(SizedBox(height: separacion));//Espacio entre una fila de teclas y otra
      final fila = <Widget>[];
      for(int j=0; j<teclasPorFila; j++){
        if( letra != tecladoEspanol.length){
          fila.add(KeyButton(letter: tecladoEspanol[letra], TeclaPulsada: TeclaPulsada,));
          letra++;
        }
      }
      columnas.add(Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: fila,));
    }

    return columnas;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: columnasTeclas(),
    );
  }

}