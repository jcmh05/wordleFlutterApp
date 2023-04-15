import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';
import 'package:wordle/componentes/componentes.dart';

class PantallaPrincipal extends StatefulWidget{

  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PantallaPrincipalState();

}

class _PantallaPrincipalState extends State<PantallaPrincipal> {

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

        body: Menu( actualizarTema: actualizarMenu),

        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text('Ajustes de la cuenta'),
                  trailing: Icon(Icons.account_circle),
                  onTap: () {
                    //Ación que hace la opción,
                  },
                ),
                ListTile(
                  title: Text('Estadísticas de juego'),
                  trailing: Icon(Icons.stacked_bar_chart),
                  onTap: () {
                    //Ación que hace la opción,

                  },
                )
              ],
            )
          )
        )

      ),
    );
  }

}