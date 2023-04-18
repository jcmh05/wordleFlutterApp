import 'package:flutter/material.dart';
import '../componentes/componentes.dart';

class Juego extends StatefulWidget{
  final int modoDeJuego;
  const Juego({Key? key, required this.modoDeJuego}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JuegoState();

}

class _JuegoState extends State<Juego> {

  // Array de letras que se manda a grid_superiores con el botón "ENVIAR"
  List<String?> listaLetras = [];

  @override
  Widget build( BuildContext context) {
    final teclaPulsada = (String tecla) {
      if( listaLetras.length > 0 && tecla == 'BORRAR'){
        listaLetras.removeLast();
      }else{
        // Si tenemos todas las letras, borramos la última para sustituirla
        if( listaLetras.length == widget.modoDeJuego){
          listaLetras.removeLast();
        }

        // Añadimos la nueva tecla a la lista y actualizamos la pantalla
        listaLetras.add(tecla);
      }
      setState(() { });
    };

    return Column(
      children: [
        //Matriz de casillas
        GridsSuperiores(numero_columnas: widget.modoDeJuego, letras: listaLetras),

        Spacer(),

        //Botón de enviar
        ElevatedButton(
          style: ButtonStyle( //Estilo para el botón
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
          ),
          onPressed: (){
            // Acción de enviar
          },
          child: Text(
            'ENVIAR',
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.grey.shade800,
              fontSize: 25,
            ),
          ),
        ),

        Spacer(),

        //Teclado
        Keyboard(TeclaPulsada: teclaPulsada),

        SizedBox(height: 10.0), //Agregar espacio entre el teclado y el borde inferior de la pantalla
      ],
    );
  }
}