import 'package:flutter/material.dart';

class KeyButton extends StatefulWidget {
  final String letter;
  final Function(String) TeclaPulsada;

  const KeyButton({Key? key, required this.letter, required this.TeclaPulsada})
      : super(key: key);

  @override
  State<KeyButton> createState() => _KeyButtonState(letter, TeclaPulsada);
}

class _KeyButtonState extends State<KeyButton> {
  String letter;
  final Function(String) TeclaPulsada;

  _KeyButtonState(this.letter, this.TeclaPulsada);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 8.2, // Ajusta este valor para cambiar el aspecto del botón
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey.shade500,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onPressed: () {
          TeclaPulsada(letter);
        },
        child: Center(
          child: Text(
            letter, //Letra que se mostrará en el botón
            style: TextStyle(
              fontSize: 14, // Cambia el tamaño de la fuente para hacer el texto más pequeño
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
