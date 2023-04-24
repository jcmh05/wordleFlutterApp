import 'package:flutter/material.dart';

class VentanaFinDeJuego extends StatelessWidget {
  final bool victoria;
  final String palabra;

  const VentanaFinDeJuego({Key? key,required this.victoria, required this.palabra}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    String titulo;

    if( victoria ){
      titulo = '¡Ganaste!🏆';
    }else{
      titulo = "¡Perdiste!😢";
    }

    return AlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: Center(
            child: Text(
              (victoria) ? "Enhorabuena" : "La palabra era: " + palabra,
              style: TextStyle(
                fontSize: 18, // Tamaño de fuente personalizado
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Volver al menú'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();

            },
            child: Text('Cerrar'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        )

    );


  }

}