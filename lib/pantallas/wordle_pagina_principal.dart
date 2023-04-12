import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class WordlePaginaPrincipal extends StatefulWidget{

  const WordlePaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WordleAppPrincipalState();

}

class _WordleAppPrincipalState extends State<WordlePaginaPrincipal> {

  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("WORDLE"),
          toolbarHeight: 72.0,
          elevation: 0.0,
          centerTitle: true, // Establecer el título centrado
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Acción a realizar al presionar el botón de búsqueda
            },
          ),
          actions: [
            IconButton(
              icon: WordleTema.temaClaro ? Icon(Icons.nightlight_outlined) : Icon(Icons.nightlight),
              onPressed: () {
                WordleTema.cambiarTema(); // Actualiza el tema al presionar el botón
                setState(() {});
              },
            ),
          ],
        ),
        body: PantallaJuego(),
      ),
    );
  }

}
