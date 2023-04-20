import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class WordlePaginaPrincipal extends StatefulWidget {
  final int modoDeJuego;

  const WordlePaginaPrincipal({Key? key, required this.modoDeJuego}) : super(key: key);

  @override
  _WordleAppPrincipalState createState() => _WordleAppPrincipalState();
}

class _WordleAppPrincipalState extends State<WordlePaginaPrincipal> {
  // Parámetros Appbar
  final alturaBarra = 72.0;

  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      home: Scaffold(
        appBar: AppBar(
          title: Row( //Fila que contendrá el botón de retroceso y logo
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Acción a realizar al presionar el botón de retroceso
                  Navigator.pop(context, true);
                },
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0,vertical: 25.0),
                  child: SizedBox(
                    height: alturaBarra,
                    child: Image.asset(
                      'assets/logo2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          toolbarHeight: alturaBarra,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: WordleTema.temaClaro ? Icon(Icons.nightlight_outlined) : Icon(Icons.nightlight),
              onPressed: () {
                WordleTema.cambiarTema();
                setState(() {});
              },
            ),
          ],
        ),

        body: Juego(modoDeJuego: widget.modoDeJuego),
      ),
    );
  }

}
