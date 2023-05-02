import 'package:flutter/material.dart';
import './componentes.dart';

class Keyboard extends StatefulWidget {
  final Function(String) TeclaPulsada;
  final String palabra;
  final teclado;
  final listaEstados;

  const Keyboard({
    Key? key,
    required this.TeclaPulsada,
    required this.palabra,
    required this.teclado,
    required this.listaEstados,
  }) : super(key: key);

  @override
  State<Keyboard> createState() =>
      _KeyboardState(TeclaPulsada: TeclaPulsada);
}

class _KeyboardState extends State<Keyboard> {
  final Function(String) TeclaPulsada;

  _KeyboardState({required this.TeclaPulsada});

  @override
  void initState() {
    super.initState();
  }

  // En la clase _KeyboardState
  @override
  Widget build(BuildContext context) {


    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), //Desactivar scroll en el teclado
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      itemCount: widget.teclado.length + 2, // Agregamos 2 para los espacios vacíos
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,    // Teclas por fila
          childAspectRatio: 0.7, // Valor para modificar el aspecto de las teclas
          mainAxisSpacing: 2.5,  // Espacio entre filas
          crossAxisSpacing: 3  // Espacio entre teclas
      ),
      itemBuilder: (BuildContext context, int index) {
        // Agrega un espacio vacío al principio de la última fila
        if (index == 20) {
          return SizedBox.shrink();
        }
        // Agrega un espacio vacío al final de la última fila
        if (index == widget.teclado.length + 1) {
          return SizedBox.shrink();
        }

        // Ajusta el índice para los botones en la última fila
        if (index > 20) {
          index -= 1;
        }

        if( widget.teclado[index] == " "){
          return SizedBox.shrink();
        }

        return KeyButton(
            letter: widget.teclado[index],
            TeclaPulsada: TeclaPulsada,
            estadoTecla: widget.listaEstados[index],
        );
      },
    );
  }

}