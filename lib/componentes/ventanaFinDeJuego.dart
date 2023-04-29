import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';
import 'package:Wordel/funciones/funciones.dart';

import '../generated/l10n.dart';

class VentanaFinDeJuego extends StatelessWidget {
  final bool victoria;
  final String palabra;
  final List<String> resultado;

  const VentanaFinDeJuego({Key? key,required this.victoria, required this.palabra, required this.resultado}) : super(key: key);

  void compartirTexto( String texto ) {
    Share.share(texto);
  }

  String textoAlCompartir( ){
    int n_intentos = resultado.length ~/ palabra.length;
    int n_maximos = palabra.length == 4 ? 5 : palabra.length==5 ? 6 : 7;
    String texto = "WORDEL - " + n_intentos.toString() + "/" + n_maximos.toString();

    if( victoria ){
      List<String> emojis = ['😀', '😁', '😂', '🤠', '😄', '🤑', '😆', '😴', '🐄', '😉', '😊', '🤯', '😌', '🥴', '😎'];
      Random random = Random();
      String emojiAleatorio = emojis[random.nextInt(emojis.length)];
      texto += n_intentos==n_maximos ? "😅\n\n" : n_intentos<=2 ? "🥱🥱🥱\n\n" : emojiAleatorio + "\n\n";
    }else{
      texto += "😞\n\n";
    }

    for( int i=0; i<resultado.length; i++){
      if ( i%palabra.length == 0 && i>0){
        texto += "\n";
      }

      var indice = i % palabra.length;
      String palabraIntroducida = "";
      for(int j=0; j<palabra.length; j++){
        palabraIntroducida += resultado[(i-indice)+j].toLowerCase();
      }

      int numero = devolverColor(palabra, palabraIntroducida, indice);
      String color = numero==1 ? "⬜" : numero==2 ? "🟨" : "🟩";
      texto += color + " ";
    }

    return texto;
  }

  @override
  Widget build(BuildContext context) {

    String titulo;

    if( victoria ){
      titulo = S.current.tituloVictoria;
    }else{
      titulo = S.current.tituloDerrota;
    }

    return AlertDialog(
        title: Text(titulo),
        content: SingleChildScrollView(
          child: Center(
            child: Text(
              (victoria) ? S.current.textoVictoria : S.current.textoDerrota + palabra,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Tamaño de fuente personalizado
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              compartirTexto(textoAlCompartir());
            },
            child: Text(S.current.compartir),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(S.current.volverAlMenu),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        )

    );


  }

}