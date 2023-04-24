import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class PantallaPrincipal extends StatefulWidget{

  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PantallaPrincipalState();

}

enum MenuOptions { opcion1, opcion2, opcion3 }

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  String _idiomaActual = 'pais1';

  void _cambiarIdioma(String nuevoIdioma) {
    setState(() {
      _idiomaActual = nuevoIdioma;
    });
  }

  void actualizarMenu() {
    setState(() {});
  }


  @override
  Widget build( BuildContext context) {
    return MaterialApp(
      theme: WordleTema.temaClaro ? WordleTema.claro() : WordleTema.oscuro(),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 72.0,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.all(8.0),
            child: PopupMenuButton<String>(
              onSelected: _cambiarIdioma,
              icon: Image.asset('assets/bandera_$_idiomaActual.png'),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'pais1',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_pais1.png', width: 24),
                        SizedBox(width: 8),
                        Text('Español'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'pais2',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_pais2.png', width: 24),
                        SizedBox(width: 8),
                        Text('English'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'pais3',
                    child: Row(
                      children: [
                        Image.asset('assets/bandera_pais3.png', width: 24),
                        SizedBox(width: 8),
                        Text('Français'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
          actions: [
            IconButton(
              icon: WordleTema.temaClaro ? Icon(Icons.nightlight_outlined) : Icon(Icons.nightlight),
              onPressed: () {
                WordleTema.cambiarTema();
                actualizarMenu();
              },
            ),
          ],
        ),
        body: Menu(actualizarTema: actualizarMenu),
      ),
    );
  }

}