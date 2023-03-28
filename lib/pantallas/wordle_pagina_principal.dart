import 'package:flutter/material.dart';
import 'package:wordle/pantallas/pantallas.dart';

class WordlePaginaPrincipal extends StatefulWidget{

  const WordlePaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WordleAppPrincipalState();

}

class _WordleAppPrincipalState extends State<WordlePaginaPrincipal> {

  @override
  Widget build( BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Wordle"),),
      body: PantallaJuego(),

      //Cajón lateral
      drawer: Drawer(
        child: SafeArea(
          child: Text("como cuando te pasa")
        ),
      ),


    );
  }

}