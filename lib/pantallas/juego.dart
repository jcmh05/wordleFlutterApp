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
        Expanded(child: GridsSuperiores(numero_columnas: widget.modoDeJuego, letras: listaLetras),),


        //Botón de enviar
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.green.shade800; // Color cuando el botón está presionado
                return Colors.green; // Color por defecto
              },
            ),
            shape: MaterialStateProperty.all<OutlinedBorder?>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            side: MaterialStateProperty.all<BorderSide>( // Agregar esta línea para agregar un borde
              BorderSide(color: Colors.black, width: 1.0),
            ),
            elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return 0.0; // Elevación cuando el botón está presionado
                return 5.0; // Elevación por defecto
              },
            ),
          ),
          onPressed: () {
            // Acción de enviar
          },
          child: Text(
            'ENVIAR',
            style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 25,
            ),
          ),
        ),




        //Teclado
        Keyboard(TeclaPulsada: teclaPulsada),

        SizedBox(height: 10.0), //Agregar espacio entre el teclado y el borde inferior de la pantalla
      ],
    );
  }
}