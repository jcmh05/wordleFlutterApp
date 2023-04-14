import 'package:flutter/material.dart';
import './componentes.dart';

class Keyboard extends StatefulWidget {
  final Function(String) TeclaPulsada;
  const Keyboard({Key? key, required this.TeclaPulsada}) : super(key: key);

  @override
  State<Keyboard> createState() =>
      _KeyboardState(TeclaPulsada: TeclaPulsada);
}

class _KeyboardState extends State<Keyboard> {
  final Function(String) TeclaPulsada;
  final tecladoEspanol = [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
    'Ñ',
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
    'BORRAR'
  ];

  _KeyboardState({required this.TeclaPulsada});

  @override
  void initState() {
    super.initState();
  }

  // En la clase _KeyboardState
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: tecladoEspanol.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 10,
            childAspectRatio: 1.2, // Ajusta este valor para modificar el aspecto de las teclas
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0),
        itemBuilder: (BuildContext context, int index) {
          return KeyButton(
              letter: tecladoEspanol[index], TeclaPulsada: TeclaPulsada);
        });
  }
}
