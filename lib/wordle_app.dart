import 'package:flutter/material.dart';
import 'package:wordle/pantallas/wordle_pagina_principal.dart';

class WordleApp extends StatelessWidget{
  const WordleApp({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Wordle App',
        theme: ThemeData(primarySwatch: Colors.blue,),
        home: WordlePaginaPrincipal(),
    );
  }
}