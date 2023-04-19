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
  var _teclaPresionada;

  @override
  void initState() {
    _teclaPresionada = false;
  }

  void _teclaPulsada(PointerUpEvent){
    setState(() {
      _teclaPresionada = true;
    });
  }

  void _teclaSoltada(PointerDownEvent){
    _teclaPresionada = false;
  }

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {

        return Listener(
          onPointerDown: _teclaPulsada,
          onPointerUp: _teclaSoltada,
          child: Transform.scale(
            scale: _teclaPresionada ? 0.85 : 1.0, // Cambiar la escala de la tecla al presionarla
            child: ElevatedButton(
                style: ButtonStyle( //Estilo para el botón
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
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                )
            ),
          ),
        );


      },
    );
  }
}