import 'package:flutter/material.dart';

class KeyButton extends StatefulWidget{
  final String letter;
  final Function(String) TeclaPulsada;

  const KeyButton({Key? key, required this.letter, required this.TeclaPulsada}) : super( key: key);

  @override
  State<KeyButton> createState() => _KeyButtonState(letter,TeclaPulsada);
}

class _KeyButtonState extends State<KeyButton> {
  String letter;
  final Function(String) TeclaPulsada;

  _KeyButtonState(this.letter, this.TeclaPulsada);

  @override void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 50,
        maxWidth: 35,
      ),
      child: ElevatedButton(
          child: Center(
            child: Text(
              letter,//Letra que se mostrará en el botón
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          style: ButtonStyle( //Estilo para el botón
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            shape: MaterialStateProperty.all<OutlinedBorder?>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
            padding: MaterialStateProperty.all<EdgeInsets?>(const EdgeInsets.all(0)),
          ),
          onPressed: (){
            TeclaPulsada(letter);
          }),
    );
  }

}