import 'package:flutter/material.dart';


class WordlePaginaPrincipal extends StatefulWidget{

  const WordlePaginaPrincipal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WordleAppPrincipalState();

}

class _WordleAppPrincipalState extends State<WordlePaginaPrincipal> {

  @override
  Widget build( BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prueba"),),
      body: Center(),
    );
  }

}