import 'package:flutter/material.dart';
import '../componentes/componentes.dart';

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
      body: Keyboard(),
      //Cajón lateral
      drawer: Drawer(
        child: SafeArea(
          child: Text("como cuando te pasa")
        ),
      ),
    );
  }

}