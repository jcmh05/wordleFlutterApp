import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class PantallaEstadisticas extends StatefulWidget {

  const PantallaEstadisticas({Key? key}) : super(key: key);

  @override
  _PantallaEstadisticasState createState() => _PantallaEstadisticasState();
}

class _PantallaEstadisticasState extends State<WordlePaginaPrincipal> {
  // Parámetros Appbar
  final alturaBarra = 72.0;

  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      home: Scaffold(
        appBar: AppBar(
          title: Row( //Fila que contendrá el botón de retroceso
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Acción a realizar al presionar el botón de retroceso
                  Navigator.pop(context, true);
                },
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

        body: Text('Estadísticas!!!!!\n\n\n🥱'),
      ),
    );
  }

}