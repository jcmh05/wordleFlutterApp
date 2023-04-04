import 'package:flutter/material.dart';
import './componentes.dart';

class Keyboard extends StatefulWidget{
  const Keyboard({Key? key}) : super( key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  @override void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Caja que contiene al botón y restringirá sus medidas
            KeyButton(letter: 'Q'),
            KeyButton(letter: 'W'),
            KeyButton(letter: 'E'),
            KeyButton(letter: 'R'),
            KeyButton(letter: 'T'),
            KeyButton(letter: 'Y'),
            KeyButton(letter: 'U'),
            KeyButton(letter: 'I'),
            KeyButton(letter: 'O'),
            KeyButton(letter: 'P'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Caja que contiene al botón y restringirá sus medidas
            KeyButton(letter: 'A'),
            KeyButton(letter: 'S'),
            KeyButton(letter: 'D'),
            KeyButton(letter: 'F'),
            KeyButton(letter: 'G'),
            KeyButton(letter: 'H'),
            KeyButton(letter: 'J'),
            KeyButton(letter: 'K'),
            KeyButton(letter: 'L'),
            KeyButton(letter: 'Ñ'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Caja que contiene al botón y restringirá sus medidas
            KeyButton(letter: 'Z'),
            KeyButton(letter: 'X'),
            KeyButton(letter: 'C'),
            KeyButton(letter: 'V'),
            KeyButton(letter: 'B'),
            KeyButton(letter: 'N'),
            KeyButton(letter: 'M'),
          ],
        ),
      ],
    );
  }



}