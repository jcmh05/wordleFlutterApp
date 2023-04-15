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
  final tamano_letra = 0.6; //Establece el tamaño de la letra respecto al botón
  Color colorBoton = Colors.grey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if( letter == "BORRAR" ){
      colorBoton = Colors.redAccent;
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ElevatedButton(
              style: ButtonStyle( //Estilo para el botón
                backgroundColor: MaterialStateProperty.all<Color>(colorBoton),
                shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                padding: MaterialStateProperty.all<EdgeInsets?>(const EdgeInsets.all(0)),
              ),
              onPressed: (){
                TeclaPulsada(letter);
              },
              child: Center(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontSize: constraints.maxHeight * tamano_letra,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              )
          );
      },
    );
  }
}